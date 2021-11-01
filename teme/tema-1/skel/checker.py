#!/usr/bin/env python

import subprocess
import shutil
import os
import sys
from collections import namedtuple


#Dataclasses do be looking good
class Task:
    def __init__(self, name="", max_points=0, number_tests=0, number_tests_passed=0):
        self.name = name
        self.max_points = max_points
        self.number_tests = number_tests
        self.number_tests_passed = number_tests_passed

    @property
    def score_task(self):
        return (self.max_points / self.number_tests) * self.number_tests_passed 

# Asta e pentru generatiile urmatoare care vor sa se joace mai tare cu valgrind
test_tuple = namedtuple("Test", "name, error")

runExec = "./tema"
useShell = True
inputFileName = "input"
memoryPass = True
numPassed = 0
memory_shame_list = []
size_header = 60

#Static files
INPUT_FILE = "INPUTS/"
OUTPUTS_FILE = "OUTPUTS/"
DEV_FILE = "DEV_OUTPUT/"
MEMORY_CHECK_FILE = "memCheck"
README_FILE = "README"


## Date pentru fiecare file
list_tasks = {}
list_tasks["ls_mkdir_touch"] = Task(name="ls_mkdir_touch", max_points=30, number_tests = 4)
list_tasks["cd"] = Task(name="cd", max_points=5, number_tests=4)
list_tasks["rm"]= Task(name="rm", max_points=5, number_tests=4)
list_tasks["rmdir"] = Task(name="rmdir", max_points=10, number_tests=4)
list_tasks["tree"] = Task(name="tree", max_points=10, number_tests=2)
list_tasks["pwd"] = Task(name="pwd", max_points=10, number_tests=2)
list_tasks["mv"]=Task(name="mv", max_points=20, number_tests=9)
nl = "\n"
memory_score = 20
readme_score = 10


def add_passed_test(name: str):
    """
    Incrementeaza cantitatea de teste trecute dintr-o anumita categorie
    Args:
        name (str): Numele testului

    Returns:
        NONE: Nu intoarce nimic, modifica campul de teste trecute din clasa
    """    

    if name.startswith("ls_") or name.startswith("touch") or name.startswith("mkdir"):
        list_tasks["ls_mkdir_touch"].number_tests_passed += 1
    elif name.startswith("cd_"):
        list_tasks["cd"].number_tests_passed += 1
    elif name.startswith("rm_"):
        list_tasks["rm"].number_tests_passed += 1
    elif name.startswith("rmdir_"):
        list_tasks["rmdir"].number_tests_passed += 1
    elif name.startswith("tree_"):
        list_tasks["tree"].number_tests_passed += 1
    elif name.startswith("pwd_"):
        list_tasks["pwd"].number_tests_passed += 1
    elif name.startswith("mv_"):
        list_tasks["mv"].number_tests_passed += 1


def calculate_score_without_memory() -> int:
    """
    Returns:
        int: The score of the person without memory points
    """ 
    return sum([task.score_task for task in list_tasks.values()]) +\
            (readme_score if os.path.exists(README_FILE) else 0)

def calculate_score() -> int:
    """
    Returns:
        int: The total score of the person
    """ 
    return calculate_score_without_memory() +\
            (memory_score if len(memory_shame_list) == 0 and calculate_score_without_memory() >= 50 else 0)
            

## Initialisation in the beggining
if not os.path.exists(OUTPUTS_FILE):
    os.mkdir(OUTPUTS_FILE)

if not os.path.exists(runExec):
    rc = subprocess.call("make", shell=useShell)
    if rc != 0:
        sys.stderr.write("make failed with status %d\n" % rc)
        sys.exit(rc)

if not os.path.exists(runExec):
    sys.stderr.write("The file %s is missing and could not be created with make" % runExec)
    sys.exit(-1)

if not os.path.exists(INPUT_FILE):
    sys.stderr.write("Could not find the inputs file.....how did you manage that?")
    sys.exit(-1)

## Start of the horror
print("\n======================= Tema 1 IOCLA =======================\n")

regular_tests = [x for x in sorted(os.listdir(INPUT_FILE)) if not x.startswith("mv_")]


for name_file in regular_tests:
    shutil.copy(INPUT_FILE + name_file, inputFileName)

    proc = os.popen('valgrind --leak-check=full \
                    --show-leak-kinds=all --track-origins=yes \
                    --log-file=\"memCheck\" '
                     + runExec + " < " +  inputFileName)
    result = proc.read().strip()
    proc.close()
    with open(OUTPUTS_FILE + "output_" + name_file, "w") as f:
        f.write(result)
    
    with open(DEV_FILE + "dev_" + name_file, "r") as dev:
        if dev.read().strip() == result:
            print("TEST " + name_file + "." *(size_header - len(name_file) - 12) + " PASSED")
            add_passed_test(name_file)
            numPassed += 1
        else:
            print("TEST " + name_file + "." *(size_header - len(name_file) - 12) + " FAILED")
            
    ## memory check
    with open("memCheck", "r") as mem:
        mem_str = mem.read().strip()
        if "All heap blocks were freed" not in mem_str:
            memory_shame_list.append(test_tuple(name_file, "memory not freed"))
        elif "Invalid read" in mem_str:
            memory_shame_list.append(test_tuple(name_file, "not enough memory allocated string"))

print("\n========================== BONUS ===========================\n")

bonus_tests = [x for x in sorted(os.listdir(INPUT_FILE)) if x.startswith("mv_")]
for name_file in bonus_tests:
    shutil.copy(INPUT_FILE + name_file, inputFileName)

    proc = os.popen('valgrind --leak-check=full \
                    --show-leak-kinds=all --track-origins=yes \
                    --log-file=\"memCheck\" '
                     + runExec + " < " +  inputFileName)
    result = proc.read().strip()
    proc.close()
    with open(OUTPUTS_FILE + "output_" + name_file, "w") as f:
        f.write(result)
    
    with open(DEV_FILE + "dev_" + name_file, "r") as dev:
        if dev.read().strip() == result:
            print("TEST " + name_file + "." *(size_header - len(name_file) - 12) + " PASSED")
            add_passed_test(name_file)
            numPassed += 1
        else:
            print("TEST " + name_file + "." *(size_header - len(name_file) - 12) + " FAILED")
            
    ## memory check
    with open("memCheck", "r") as mem:
        mem_str = mem.read().strip()
        if "All heap blocks were freed" not in mem_str:
            memory_shame_list.append(test_tuple(name_file, "memory not freed"))
        elif "Invalid read" in mem_str:
            memory_shame_list.append(test_tuple(name_file, "not enough memory allocated string"))

## Memory check 
print("\n======================= Memory Check =======================\n")

if len(memory_shame_list) == 0 and calculate_score_without_memory() >= 50:
    if numPassed == len(os.listdir(INPUT_FILE)):
        print(f"Very few people have gone as far as you have.{nl}Good Job! I hope you are proud of yourself the least I can give {nl}you is {memory_score}p!")
    else:
        print(f"No memory problems, really good job! - {memory_score}p!")
else:
    print(f"At least 50 points are necessary in order to get the points for memory.{nl}")

for shame in memory_shame_list:
    print("Failed Test: " + shame.name + "-- probable problem: " + shame.error)


## Readme
print("\n======================= README Check =======================\n")
if not os.path.exists(README_FILE):
    print("NO README MAKES ME SAD :((((")
else:
    print(README_FILE + " present. Good job!")

## The long awaited
print(f"{nl}======================= Score ==================== {calculate_score()}p/120p{nl}")

## Cleanup
if os.path.exists(MEMORY_CHECK_FILE):
    os.remove(MEMORY_CHECK_FILE)
if os.path.exists(runExec):
    os.remove(runExec)
if os.path.exists("input"):
    os.remove("input")

