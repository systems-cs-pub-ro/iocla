section .text

global expression
global term
global factor

factor:
        push    ebp
        mov     ebp, esp
        
        leave
        ret

term:
        push    ebp
        mov     ebp, esp
        
        leave
        ret

expression:
        push    ebp
        mov     ebp, esp
        
        leave
        ret
