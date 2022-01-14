;;; macro to use printf with 32bit parameters:
;;; - 1st parameter MUST be an immediate in backquotes `EAX=%d ECX=%x \n\x0`
;;;     escape \n and \x0 only work with backquotes
;;; - rest of parameters MUST be 32bit
;;; - gen purpose and flags are preserved
;;; - stack is cleaned
%macro PRINTF32 1-*
    pushf
    pushad
    jmp     %%endstr
%%str:       db      %1
%%endstr:
%rep  %0 - 1
%rotate -1
    push    dword %1
%endrep
    push %%str
    call printf
    add esp, 4*%0
    popad
    popf
%endmacro
