#!/usr/bin/env python

import argparse
import subprocess
import shutil
import os
import sys

# IMPORTANT! variable `type` in function test_suite must be "print_easy"
#                                                           "print_hard"
#                                                           "clear_easy"
#                                                           "clear_hard"
#                                                           "analyse"
#

#============================== ARGUMENTS ==============================#

argParser = argparse.ArgumentParser(description="Python Checker for PCLP2 Homework 1", prog="python3 checker.py")
argParser.add_argument("-v", "--valgrind", action="store_true", help="Run tests with `valgrind`. Tests may take longer to finish.")
argParser.add_argument("-o", "--output", action="store_true", help="Create output files for the selected tests in `tmp` directory.")
argParser.add_argument("-c", "--clear", action="store_true", help="Run tests for `clear` command.")
argParser.add_argument("-a", "--analyse", action="store_true", help="Run tests for `analyse` command.")
argParser.add_argument("-p", "--print", action="store_true", help="Run tests for `print` command.")
argParser.add_argument("--all", action="store_true", help="Run all tests.")
args = argParser.parse_args()

if len(sys.argv) == 1:
    argParser.print_help()
    exit(0)
#============================== CONSTANTS ==============================#

withValgrind = False
memLogFileFlag = "--log-file="
memLogDir = "valgrind_logs"
memLineCheck = "All heap blocks were freed -- no leaks are possible"
memPoints = 0
valgrindFlags = "--leak-check=full --show-leak-kinds=all --track-origins=yes"
if args.valgrind:
    withValgrind = True
    memPoints = 20

execName = "main"
execDir = "../src"
execPath = f"{execDir}/{execName}"
testsDir = "input"
outputDir = "tmp"
refDir = "output"
csChecker = "cs/cs.sh"

runExec = "./" + execPath

readme = execDir + "README"
readmeMD = readme + ".md"
readmePoints = 10
useShell = True

header = "======================= Tema 1 PCLP2 ======================="

#============================== FUNCTIONS ==============================#

def check_mem_log(memLog):
    with open(memLog) as f:
        datafile = f.readlines()
    for line in datafile:
        if memLineCheck in line:
            return True
    return False

def test_suite(type, typeScore, typeNo):
    global memPoints
    totalSuitePoints = 0
    for n in range(1, typeNo + 1):
        commandsFile = f"{testsDir}/commands_{type}_{n}.in"
        binaryFile = f"{testsDir}/sensors_{type}_{n}.dat"
        procString = f"{runExec} {binaryFile} < {commandsFile}"

        if withValgrind:
            procString = f"valgrind {memLogFileFlag}{memLogDir}/{type}_{n}.log {valgrindFlags} {procString}"
        proc = os.popen(procString)

        result = proc.read()
        expectedResult = open(f"{refDir}/{type}_{n}.ref", "r").read()
        proc.close()

        if args.output:
            outputFile = open(f"{outputDir}/{type}_{n}.out", "w")
            outputFile.write(result)
            outputFile.close()

        if expectedResult == result and withValgrind and check_mem_log(f"{memLogDir}/{type}_{n}.log"):
            totalSuitePoints += typeScore
            print(f"Test `{type}_{n}` PASSED: {typeScore} / {typeScore}")
        elif expectedResult == result and not withValgrind:
            print(f"Test `{type}_{n}` OUT = REF, without memory check: {typeScore} / {typeScore}")
            totalSuitePoints += typeScore
            memPoints = 0
        elif expectedResult == result:
            print(f"Test `{type}_{n}` OUT = REF, memory check failed: {typeScore} / {typeScore}")
            totalSuitePoints += typeScore
            memPoints = 0
        else:
            print(f"Test `{type}_{n}` FAILED: 0 / {typeScore}")

    print(f"\n`{type}` tests: {totalSuitePoints} / {typeScore * typeNo}\n")
    return totalSuitePoints

print("\n" + header)
#============================== INIT TEST ==============================#
print("\n======================== INIT TEST =========================\n")

rc = subprocess.call(f"make -C {execDir}", shell=useShell)
if rc != 0:
    sys.stderr.write("make failed with status %d\n" % rc)
    sys.exit(rc)

if not os.path.exists(execPath):
    sys.stderr.write("The file %s is missing and could not be created with \'make\'" % execPath)
    sys.exit(-1)

points = 0

#=========================== README AND CS TEST ============================#
print("\n==================== README AND CS TEST ====================\n")

csRes = subprocess.Popen([f"./{csChecker}", f"{execDir}"], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
csRes.wait()
csResString = csRes.stdout.read().decode()
if os.path.exists(readme) and len(open(readme).readlines()) > 25 or os.path.exists(readmeMD) and len(open(readmeMD).readlines()) > 25:
    if "ERROR" not in csResString:
        points += 10
        print(f"Coding Style OK | README/README.md found. {points} / 10")
    else:
        points += 0
        print(f"Coding Style ERROR | README/README.md found. {points} / 10\n")
        for line in csResString.splitlines():
            if "ERROR" in line:
                print(line)
else:
    if "ERROR" not in csResString:
        points += 10
        print(f"Coding Style OK | README/README.md not found or is empty. {points} / 10")
    else:
        print(f"Coding Style ERROR | README/README.md not found or is empty. {points} / 10\n")
        for line in csResString.splitlines():
            if "ERROR" in line:
                print(line)

#========================= PRINT EASY TESTS =========================#

if args.print or args.all:
    print("\n==================== PRINT EASY TESTS ======================\n")
    printEasyTestNo = 5
    printEasyTestPoints = 2
    points += test_suite("print_easy", printEasyTestPoints, printEasyTestNo)

#========================= PRINT HARD TESTS =========================#

if args.print or args.all:
    print("\n==================== PRINT HARD TESTS ======================\n")
    printHardTestNo = 5
    printHardTestPoints = 4
    points += test_suite("print_hard", printHardTestPoints, printHardTestNo)

#========================= ClEAR EASY TESTS =========================#

if args.clear or args.all:
    print("\n==================== CLEAR EASY TESTS ======================\n")
    clearEasyTestNo = 5
    clearEasyTestPoints = 2
    points += test_suite("clear_easy", clearEasyTestPoints, clearEasyTestNo)

#========================= ClEAR HARD TESTS =========================#

if args.clear or args.all:
    print("\n==================== CLEAR HARD TESTS ======================\n")
    clearHardTestNo = 5
    clearHardTestPoints = 2
    points += test_suite("clear_hard", clearHardTestPoints, clearHardTestNo)

#========================== ANALYSE TESTS ==========================#

if args.analyse or args.all:
    print("\n====================== ANALYSE TESTS =======================\n")
    analyseTestNo = 5
    analyseTestPoints = 4
    points += test_suite("analyse", analyseTestPoints, analyseTestNo)

if (points < 50) and (withValgrind == True):
    memPoints = 0

print(f"\n====================== TOTAL {points + memPoints} / 100 ======================\n")