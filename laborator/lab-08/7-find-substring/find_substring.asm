%include "../utils/printf32.asm"

section .data
source_text: db "ABCABCBABCBABCBBBABABBCBABCBAAACCCB", 0
substring: db "BABC", 0

source_length: dd 1
substr_length: dd 4

print_format: db "Substring found at index: ", 0

section .text
extern printf
global main
main:
    push ebp
    mov ebp, esp

    ; TODO: Fill source_length with the length of the source_text string.
    ; Find the length of the string using scasb.

    ; TODO: Print the start indices for all occurrences of the substring in source_text

    leave
    ret
