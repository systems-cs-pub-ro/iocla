#!/bin/bash

fail() {
    echo "[ERROR] $1"
    exit 1
}

shopt -s extglob
rm -f !("tests"|"check.sh"|"checker.c"|"Makefile")
if [ -f ../../task3.asm ]; then
	cp -r ../../task3.asm .
else
	cp -r ../task3.asm .
fi
sleep 2     # to avoid "make: warning:  Clock skew detected."

if [ ! -e Makefile ]; then
    fail "Makefile not found"
fi

make 1>/dev/null || exit 1

if [ ! -e checker ]; then
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

echo "=================== Task 3 ===================="

total=0
for i in 1 2 3 4 5 6; do
    ./checker < "tests/in/${i}.in" | xargs > "tests/out/${i}.out"
    out=$(diff "tests/ref/${i}.ref" "tests/out/${i}.out" 2>&1)

    if [ -z "$out" ]; then
        total=$(( total + 4 ))
        echo "Test ${i}					  4p/4p"
    else
        echo "Test ${i}					  0p/4p"
    fi
done

echo
if [[ "$total" == "0" ]]; then
	echo "Coding Style				  0p/1p"
else
	echo "Coding Style				  1p/1p"
	total=$((total + 1))
fi

echo
printf "Total score:				%02dp/25p\n" ${total}

echo "task-3:${total}" >> ../../.results