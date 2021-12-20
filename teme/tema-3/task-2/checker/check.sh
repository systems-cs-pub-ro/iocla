#!/bin/bash

INPUTS="tests/in/"
OUTPUTS="tests/out/"
REFS="tests/ref/"

IN_EXT=".in"
OUT_EXT=".out"
REF_EXT=".ref"

TASK_SCORE1=2
TASK_SCORE2=3
MAX_SCORE=25
TOTAL=0

make copy > /dev/null 2>&1 && make > /dev/null 2>&1

echo "=================== Task 2 ===================="

for i in 1 2 3 4 5; do
	./checker 0 < "${INPUTS}${i}${IN_EXT}" > "${OUTPUTS}${i}${OUT_EXT}"
	diff "${OUTPUTS}${i}${OUT_EXT}" "${REFS}${i}${REF_EXT}" > /dev/null
	if [[ $? == "0" ]]; then
		echo "Test $i					  ${TASK_SCORE1}p/${TASK_SCORE1}p"
		TOTAL=$((TOTAL + TASK_SCORE1))
	else
		echo "Test $i					  0p/${TASK_SCORE1}p"
	fi
done

for i in 6 7 8 9 10; do
	./checker 1 < "${INPUTS}${i}${IN_EXT}" > "${OUTPUTS}${i}${OUT_EXT}"
	diff "${OUTPUTS}${i}${OUT_EXT}" "${REFS}${i}${REF_EXT}" > /dev/null
	if [[ $? == "0" ]]; then
		if [[ $i == "6" ]] || [[ $i == "7" ]]; then
			echo "Test $i					  ${TASK_SCORE1}p/${TASK_SCORE1}p"
			TOTAL=$((TOTAL + TASK_SCORE1))
		else
			echo "Test $i					  ${TASK_SCORE2}p/${TASK_SCORE2}p"
			TOTAL=$((TOTAL + TASK_SCORE2))
		fi
	else
		if [[ $i == "6" ]] || [[ $i == "7" ]]; then
			echo "Test $i					  0p/${TASK_SCORE1}p"
		else
			echo "Test $i					  0p/${TASK_SCORE2}p"
		fi
	fi
done

echo
if [[ "$TOTAL" == "0" ]]; then
	echo "Coding Style				  0p/2p"
else
	echo "Coding Style				  2p/2p"
	TOTAL=$((TOTAL + 2))
fi

echo
printf "Total score:				%02dp/%02dp\n" ${TOTAL} ${MAX_SCORE}

make clean > /dev/null 2>&1

echo "task-2:${TOTAL}" >> ../../.results
