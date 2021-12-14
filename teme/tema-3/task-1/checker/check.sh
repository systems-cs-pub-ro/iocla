#!/bin/bash

fail() {
    echo "[ERROR] $1"
    exit 1
}

shopt -s extglob
rm -f !("tests"|"check.sh"|"Makefile"|"checker.c")
if [ -f ../../task1.asm ]; then
	cp -r ../../task1.asm .
else
	cp -r ../task1.asm .
fi
sleep 1     # to avoid "make: warning:  Clock skew detected."

if [ ! -f Makefile ]; then
    fail "Makefile not found"
fi

make 1>/dev/null || exit 1

if [ ! -f checker ]; then
    fail "checker not found"
fi

if [ ! -e tests/in ]; then
    fail "tests/in not found"
fi

if [ ! -e tests/out ]; then
    mkdir tests/out
fi

if [ ! -e tests/ref ]; then
    fail "tests/ref not found"
fi

echo "=================== Task 1 ===================="

total=0
for i in {1..6}; do
    ./checker < "tests/in/${i}.in" | xargs > "tests/out/${i}.out"
    out=$(diff "tests/ref/${i}.ref" "tests/out/${i}.out")

    if [ -z "$out" ]; then
        total=$(( total + 4 ))
        echo "Test ${i}  				  4p/4p"
    else
        echo "Test ${i}  				  0p/4p"
    fi
done

echo
echo "Coding Style				  1p/1p"
total=$(( total + 1 ))

echo
echo "Total Score:				${total}p/25p"
echo "task-1:$total" >> ../../.results
