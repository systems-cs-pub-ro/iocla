#!/usr/bin/env python

import subprocess
import shutil
import os
import sys
from collections import namedtuple

# Asta e pentru generatiile urmatoare care vor sa se joace mai tare cu valgrind
test_tuple = namedtuple("Test", "name, error")

runExec = "./main"
useShell = True
inputFileName = "input"
memoryPass = True
numPassed = 0
memory_shame_list = []
size_header = 60

# Static files
INPUT_FILE = "INPUTS/"
OUTPUTS_FILE = "OUTPUTS/"
DEV_FILE = "DEV_OUTPUT/"
MEMORY_CHECK_FILE = "memCheck"
README_FILE = "README"


## Date pentru fiecare file
number_tests_passed = 0
number_tests = 0
nl = "\n"
memory_score = 20
readme_score = 10


def calculate_score_without_memory():
    """
    Returns:
        int: The score of the person without memory points
    """
    return (
        (70.0 / number_tests) * number_tests_passed
        + (readme_score if has_readme() else 0)
        if number_tests_passed > 0
        else 0
    )


def calculate_score():
    """
    Returns:
        int: The total score of the person
    """
    score = calculate_score_without_memory()
    return score + (memory_score if len(memory_shame_list) == 0 and score >= 50 else 0)


def has_readme():
    for file in os.listdir(os.getcwd()):
        if file.startswith("README"):
            return True
    return False


## Initialisation in the beggining
if not os.path.exists(OUTPUTS_FILE):
    os.mkdir(OUTPUTS_FILE)

rc = subprocess.call("make", shell=useShell)
if not os.path.exists(runExec):
    sys.stderr.write(
        "The file %s is missing and could not be created with make" % runExec
    )
    sys.exit(-1)

if not os.path.exists(INPUT_FILE):
    sys.stderr.write("Could not find the inputs file.....how did you manage that?")
    sys.exit(-1)

## Start of the horror
print("\n======================= Tema 1 IOCLA =======================\n")

regular_tests = sorted(os.listdir(INPUT_FILE))
number_tests = len(regular_tests)

for name_file in regular_tests:
    shutil.copy(INPUT_FILE + name_file, inputFileName)

    proc = os.popen(
        'valgrind --leak-check=full \
                    --show-leak-kinds=all --track-origins=yes \
                    --log-file="memCheck" '
        + runExec
        + " < "
        + inputFileName
    )
    result = proc.read().strip()
    proc.close()
    with open(OUTPUTS_FILE + "output_" + name_file, "w") as f:
        f.write(result)

    with open(DEV_FILE + "dev_" + name_file, "r") as dev:
        if dev.read().strip() == result:
            print(
                "TEST "
                + name_file
                + "." * (size_header - len(name_file) - 12)
                + " PASSED"
            )
            number_tests_passed += 1
            numPassed += 1
        else:
            print(
                "TEST "
                + name_file
                + "." * (size_header - len(name_file) - 12)
                + " FAILED"
            )

    ## memory check
    with open("memCheck", "r") as mem:
        mem_str = mem.read().strip()
        if "All heap blocks were freed" not in mem_str:
            memory_shame_list.append(test_tuple(name_file, "memory not freed"))
        elif "Invalid read" in mem_str:
            memory_shame_list.append(
                test_tuple(name_file, "not enough memory allocated string")
            )
if len(memory_shame_list) == 0 and calculate_score_without_memory() >= 50:
    print("Test memory.......................................... PASSED")
elif calculate_score_without_memory() < 50:
    print("Test memory.......................................... FAILED")
    print("You need at least 50 points to get memory points")
else:
    print("Test memory.......................................... FAILED")

for shame in memory_shame_list:
    print("Failed Test: " + shame.name + "-- probable problem: " + shame.error)


## Readme
print("\n======================= README Check =======================\n")
if has_readme():
    print(README_FILE + " present. Good job!")
else:
    print("No readme is a crime towards humanity")

## The long awaited
print(
    "\n======================= Score ======================= " + str(calculate_score()) + "p/100\n"
)

## Cleanup
if os.path.exists(MEMORY_CHECK_FILE):
    os.remove(MEMORY_CHECK_FILE)
if os.path.exists(runExec):
    os.remove(runExec)
if os.path.exists("input"):
    os.remove("input")

