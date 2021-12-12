#!/bin/bash

fail() {
    echo "[ERROR] $1"
    exit 1
}

echo "=================== Task 4 ===================="

shopt -s extglob
rm -f !("tests"|"check.sh"|"checker.c"|"Makefile")

make copy > /dev/null 2>&1 && make > /dev/null 2>&1

sleep 1     # to avoid "make: warning:  Clock skew detected."

if [ ! -f Makefile ]; then
    fail "Makefile not found"
fi

make 1>/dev/null || exit 1

if [ ! -f task4 ]; then
    fail "task4 not found"
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

score=0
for i in {0..11}; do
    ./task4 < "tests/in/${i}.in" > "tests/out/${i}.out"
    out=$(diff "tests/ref/${i}.ref" "tests/out/${i}.out")

    if [ -z "$out" ]; then
        if [ $i -eq 0 ]; then
            score=$((score + 1))
            printf "Test %02d 				  1p/1p\n" $i
        else
            score=$((score + 2))
            printf "Test %02d 				  2p/2p\n" $i
        fi
        
    else
        if [ $i -eq 0 ]; then
            printf "Test %02d 				  0p/1p\n" $i
        else
            printf "Test %02d 				  0p/2p\n" $i
        fi
    fi
done

echo
echo "Coding Style				  2p/2p"
score=$((score + 2))

make clean > /dev/null 2>&1
echo
echo "Total Score: 				${score}p/25p"

echo "task-4:${score}" >> ../../.results
