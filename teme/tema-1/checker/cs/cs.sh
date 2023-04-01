#!/bin/bash

CHECKPATCH="$(dirname "$0")/checkpatch.pl"
DOS2UNIX="$(dirname "$0")/.dos2unix"

usage()
{
    echo "Usage: $0 file"
    echo "       $0 directory"
}

check_coding_style()
{

    declare -a IGNORED_FLAGS=(
        SPLIT_STRING                # kernel specific convention
        SSCANF_TO_KSTRTO            # kernel specific convention
        NEW_TYPEDEFS                # kernel specific convention
        VOLATILE                    # kernel specific convention
        AVOID_EXTERNS               # kernel specific convention
        CONST_STRUCT                # kernel specific convention
        NOT_UNIFIED_DIFF            # kernel specific convention
        SPDX_LICENSE_TAG            # kernel specific convention
        BLOCK_COMMENT_STYLE         # kernel specific convention
        EMBEDDED_FUNCTION_NAME      # DN -> not required for PC: Prefer using '"%s...", __func__' to using 'main', this function's name, in a string
        MALFORMED_INCLUDE           # DN -> not required for PC: ERROR:MALFORMED_INCLUDE: malformed #include filename
        CONSTANT_COMPARISON         # DN -> not required for PC: WARNING:CONSTANT_COMPARISON: Comparisons should place the constant on the right side of the test
        TYPO_SPELLING               # DN -> not required for PC: CHECK:TYPO_SPELLING: 'alocate' may be misspelled - perhaps 'allocate'?
    )

    local ignored_flags_combined=$(printf ",%s" "${IGNORED_FLAGS[@]}")
    ignored_flags_combined=${ignored_flags_combined:1}

    "${DOS2UNIX}" "${1}" 1> /dev/null 2>&1 

    "${CHECKPATCH}" \
        --no-tree \
        --terse \
        --show-types \
        --no-summary \
        --max-line-length=80 \
        --tab-size=4 \
        --strict \
        --ignore "${ignored_flags_combined}" \
        -f "${1}"
}

export CHECKPATCH="${CHECKPATCH}"
export DOS2UNIX="${DOS2UNIX}"
export -f check_coding_style

if [ $# -eq 0 ] || [ "$1" = "-h" ]; then
    usage 0
elif [ $# -eq 1 ] && [ -f "$1" ]; then
    check_coding_style "$1"
else
    TARGET_DIR="."
    if [ $# -eq 1 ] && [ -d "$1" ]; then
        TARGET_DIR="$1"
    fi

    find "${TARGET_DIR}" -type f -regextype posix-egrep -regex '.*\.(c|h)' -exec bash -c 'check_coding_style "{}"' \;
fi
