;-------------------------------------------------------------
; This procedure receives three constants a, b, c and 
; pointers to two roots via the stack. It computes the two
; real roots if they exist and returns them in root1 & root2. 
; In this case, EAX = 1. If no real roots exist, EAX = 0.
;-------------------------------------------------------------
%define   a       qword[EBP+8]
%define   b       qword[EBP+16]
%define   c       qword[EBP+24]
%define   root1   dword[EBP+32]
%define   root2   dword[EBP+36]

segment .text
global  quad_roots

quad_roots:
      enter   0,0
      fld     a              ; a
      fadd    ST0            ; 2a
      fld     a              ; a,2a
      fld     c              ; c,a,2a
      fmulp   ST1            ; ac,2a
      fadd    ST0            ; 2ac,2a
      fadd    ST0            ; 4ac,2a
      fchs                   ; -4ac,2a
      fld     b              ; b,-4ac,2a
      fld     b              ; b,b,-4ac,2a
      fmulp   ST1            ; b*b,-4ac,2a
      faddp   ST1            ; b*b-4ac,2a
      ftst                   ; compare (b*b-4ac) with 0
      fstsw   AX             ; store status word in AX
      sahf
      jb      no_real_roots
      fsqrt                  ; sqrt(b*b-4ac),2a
      fld     b              ; b,sqrt(b*b-4ac),2a
      fchs                   ; -b,sqrt(b*b-4ac),2a
      fadd    ST1            ; -b+sqrt(b*b-4ac),sqrt(b*b-4ac),2a
      fdiv    ST2            ; -b+sqrt(b*b-4ac)/2a,sqrt(b*b-4ac),2a
      mov     EAX,root1
      fstp    qword[EAX]     ; store root1
      fchs                   ; -sqrt(b*b-4ac),2a
      fld     b              ; b,sqrt(b*b-4ac),2a
      fsubp   ST1            ; -b-sqrt(b*b-4ac),2a
      fdivrp  ST1            ; -b-sqrt(b*b-4ac)/2a
      mov     EAX,root2
      fstp    qword[EAX]     ; store root2
      mov     EAX,1          ; real roots exist
      jmp     short done
no_real_roots:
      sub     EAX,EAX        ; EAX = 0 (no real roots)
done:
      leave	
      ret