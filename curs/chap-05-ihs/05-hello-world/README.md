# chap-03-demo

1. Demo gdb
- make
- gdb hello
- Comands: b main, r, n
- set $eax = 0xffffffff
- set $eip = main

2. Demo gdb
 step through hello.asm to inspect the changes to the following registers:
  * EAX, AX, AH, AL
  * EFLAGS
  * EIP
Note: Instructions to whatch are: MOV, ADD, JMP

3. Demo Inspect ~/.gdbinit 
- less ~/.gdbinit 

cleanup: 
set disassembly-flavor intel
set history save on



