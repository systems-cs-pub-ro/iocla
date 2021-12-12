#!/bin/bash

OUTPUT="cpuid.out"

SMALL_TASK_SCORE=1
BIG_TASK_SCORE=3
MAX_SCORE=10
TOTAL=0

make copy > /dev/null 2>&1 && make > /dev/null 2>&1

echo "============== cpuid bonus task ==============="

./checker > "$OUTPUT"

VENDOR_ID=$(cat $OUTPUT | head -n 1 | cut -d':' -f 2)
REF_VENDOR_ID=$(cat /proc/cpuinfo | grep vendor_id | uniq | cut -d':' -f 2)

if [[ "$VENDOR_ID" == "$REF_VENDOR_ID" ]]; then
    echo "Vendor ID				  ${BIG_TASK_SCORE}p/${BIG_TASK_SCORE}p"
    TOTAL=$((TOTAL + BIG_TASK_SCORE))
else
    echo "Vendor ID				  0p/${BIG_TASK_SCORE}p"
fi

HAVE_VMX=0
HAVE_RDRAND=0
HAVE_AVX=0

# Check if VMX is supported
if [ -n "$(cat /proc/cpuinfo | grep -o "vmx" | uniq)" ]; then
    HAVE_VMX=1
fi

# Check if RDRAND is supported
if [ -n "$(cat /proc/cpuinfo | grep -o "rdrand" | uniq)" ]; then
    HAVE_RDRAND=1
fi

# Check if AVX is supported
if [ -n "$(cat /proc/cpuinfo | grep -o "avx" | uniq)" ]; then
    HAVE_AVX=1
fi

CPU_FEATURES=$(cat $OUTPUT | head -n 2 | tail -n 1)
VMX=$(echo $CPU_FEATURES | cut -d',' -f1 | cut -d' ' -f2)
RDRAND=$(echo $CPU_FEATURES | cut -d',' -f2 | cut -d' ' -f3)
AVX=$(echo $CPU_FEATURES | cut -d',' -f3 | cut -d' ' -f3)

if [[ "$HAVE_VMX" == "$VMX" ]]; then
    echo "VMX					  ${SMALL_TASK_SCORE}p/${SMALL_TASK_SCORE}p"
    TOTAL=$((TOTAL + SMALL_TASK_SCORE))
else
    echo "VMX					  0p/${SMALL_TASK_SCORE}p"
fi

if [[ "$HAVE_RDRAND" == "$RDRAND" ]]; then
    echo "RDRAND					  ${SMALL_TASK_SCORE}p/${SMALL_TASK_SCORE}p"
    TOTAL=$((TOTAL + SMALL_TASK_SCORE))
else
    echo "RDRAND					  0p/${SMALL_TASK_SCORE}p"
fi

if [[ "$HAVE_AVX" == "$AVX" ]]; then
    echo "AVX					  ${SMALL_TASK_SCORE}p/${SMALL_TASK_SCORE}p"
    TOTAL=$((TOTAL + SMALL_TASK_SCORE))
else
    echo "AVX					  0p/${SMALL_TASK_SCORE}p"
fi

CACHE_LINE_REF=$(getconf -a | grep LEVEL2_CACHE_LINESIZE | cut -d' ' -f15)
CACHE_SIZE_REF=$((`getconf -a | grep LEVEL2_CACHE_SIZE | cut -d' ' -f19 | tr -d '\n'` / 1024 ))

CACHE=$(cat $OUTPUT | tail -n 1)
CACHE_LINE=$(echo $CACHE | cut -d',' -f1 | cut -d' ' -f3)
CACHE_SIZE=$(echo $CACHE | cut -d',' -f2 | cut -d' ' -f4)

if [[ "$CACHE_LINE_REF" == "$CACHE_LINE" ]]; then
    echo "Cache Line				  ${SMALL_TASK_SCORE}p/${SMALL_TASK_SCORE}p"
    TOTAL=$((TOTAL + SMALL_TASK_SCORE))
else
    echo "Cache Line				  0p/${SMALL_TASK_SCORE}p"
fi

if [[ "$CACHE_SIZE_REF" == "$CACHE_SIZE" ]]; then
    echo "Cache Size				  ${SMALL_TASK_SCORE}p/${SMALL_TASK_SCORE}p"
    TOTAL=$((TOTAL + SMALL_TASK_SCORE))
else
    echo "Cache Size				  0p/${SMALL_TASK_SCORE}p"
fi

echo
echo "Coding Style				  2p/2p"
TOTAL=$((TOTAL + 2))

echo
echo "Total Score:				${TOTAL}p/${MAX_SCORE}p"

echo "bonus_cpuid:${TOTAL}" >> ../../.results
