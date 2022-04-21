#!/bin/bash

cd task-1
make build > /dev/null 2>/dev/null
./checker
make clean > /dev/null 2>/dev/null

cd ../task-2
make build > /dev/null 2> /dev/null
./checker
make clean > /dev/null 2> /dev/null

cd ../task-3
make check_beaufort > /dev/null  2> /dev/null
./check_beaufort
make clean > /dev/null  2> /dev/null

cd ../task-4
make check_spiral > /dev/null  2> /dev/null
./check_spiral
make clean > /dev/null  2> /dev/null

cd ..
