NASM=nasm
GCC=gcc

all: asm_call_c c_call_asm inline_asm

asm_call_c: asm_call_c_main.o asm_call_c_sum.o
	$(GCC) asm_call_c_main.o asm_call_c_sum.o -no-pie -o asm_call_c

asm_call_c_main.o: asm_call_c_main.asm
	$(NASM) -felf64 asm_call_c_main.asm -o asm_call_c_main.o

asm_call_c_sum.o: asm_call_c_sum.c
	$(GCC) -c asm_call_c_sum.c -o asm_call_c_sum.o

c_call_asm: c_call_asm_main.o c_call_asm_sum.o
	$(GCC) c_call_asm_main.o c_call_asm_sum.o -no-pie -o c_call_asm

c_call_asm_main.o: c_call_asm_main.c
	$(GCC) -c c_call_asm_main.c -o c_call_asm_main.o

c_call_asm_sum.o: c_call_asm_sum.asm
	$(NASM) -felf64 c_call_asm_sum.asm -o c_call_asm_sum.o

inline_asm: inline_asm.o
	$(GCC) inline_asm.o -o inline_asm

inline_asm.o: inline_asm.c
	$(GCC) -masm=intel -c inline_asm.c -o inline_asm.o

clean:
	rm -f *.o asm_call_c c_call_asm inline_asm
