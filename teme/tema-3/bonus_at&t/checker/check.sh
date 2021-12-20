#!/bin/bash

INPUTS="tests/in/"
OUTPUTS="tests/out/"
REFS="tests/ref/"

IN_EXT=".in"
OUT_EXT=".out"
REF_EXT=".ref"

TASK_SCORE=3
MAX_SCORE=10
TOTAL=0

make copy > /dev/null 2>&1 && make > /dev/null 2>&1

echo "=============== AT&T bonus task ==============="

for i in 1 2 3 ; do
	./checker < "${INPUTS}${i}${IN_EXT}" > "${OUTPUTS}${i}${OUT_EXT}"
	diff "${OUTPUTS}${i}${OUT_EXT}" "${REFS}${i}${REF_EXT}" > /dev/null
	if [[ $? == "0" ]]; then
		echo "Test $i					  ${TASK_SCORE}p/${TASK_SCORE}p"
		TOTAL=$((TOTAL + TASK_SCORE))
	else
		echo "Test $i					  0p/${TASK_SCORE}p"
	fi
done

echo
if [[ "$TOTAL" == "0" ]]; then
	echo "Coding Style				  0p/1p"
else
	echo "Coding Style				  1p/1p"
	TOTAL=$((TOTAL + 1))
fi

echo
printf "Total score:				%02dp/%02dp\n" ${TOTAL} ${MAX_SCORE}

make clean > /dev/null 2>&1

echo "bonus_at&t:${TOTAL}" >> ../../.results
