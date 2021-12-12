#!/bin/bash

MAX_SCORE=100
TOTAL=0
RESULTS=".results"

# do the mandatory tasks first
for dir in task*; do
	if [ -d "$dir" ]; then
		make --no-print-directory --silent -C ${dir}/checker check 2> /dev/null
		RESULT=$(cat "$RESULTS" 2> /dev/null | grep "$dir" | cut -d ':' -f2)
		TOTAL=$((TOTAL + RESULT))
	fi
done

# then do the bonus tasks
for dir in bonus*; do
	if [ -d "$dir" ]; then
		make --no-print-directory --silent -C ${dir}/checker check 2> /dev/null
		RESULT=$(cat "$RESULTS" 2> /dev/null | grep "$dir" | cut -d ':' -f2)
		TOTAL=$((TOTAL + RESULT))
	fi
done

echo "==============================================="
echo "Assignment Total Score:			${TOTAL}/${MAX_SCORE}"
echo "==============================================="

rm $RESULTS
