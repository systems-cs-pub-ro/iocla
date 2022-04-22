#!/bin/bash

TASK1=1
TASK2=2
TASK3=3
TASK4=4

if (test $# -eq 0) || (test $1 -eq $TASK1); then
    cd task-1
    make build > /dev/null 2>/dev/null
    ./checker
    make clean > /dev/null 2>/dev/null
    cd ..
fi

if (test $# -eq 0) || (test $1 -eq $TASK2); then
    cd task-2
    make build > /dev/null 2> /dev/null
    ./checker
    make clean > /dev/null 2> /dev/null
    cd ..
fi

if (test $# -eq 0) || (test $1 -eq $TASK3); then
    cd task-3
    make check_beaufort > /dev/null  2> /dev/null
    ./check_beaufort
    make clean > /dev/null  2> /dev/null
    cd ..
fi

if (test $# -eq 0) || (test $1 -eq $TASK4); then
    cd task-4
    make check_spiral > /dev/null  2> /dev/null
    ./check_spiral
    make clean > /dev/null  2> /dev/null
    cd ..
fi