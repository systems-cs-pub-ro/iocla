FILES = overflow_example.c auth_overflow.c
CFLAGS_CANARY = -m32 -fno-pie -g -Fdwarf -fstack-protector
CFLAGS_NOCANARY = -m32  -fno-pie -g -Fdwarf #-fno-stack-protector
CFLAGS_PIE = -m32 -g -Fdwarf -fstack-protector

all : overflow_example canary nocanary pie

canary: auth_overflow.c
	gcc $(CFLAGS_CANARY) -S -masm=intel -o canary.s $<
	gcc $(CFLAGS_CANARY) -masm=intel -Wa,-adhln $< > canary.lst
	gcc $(CFLAGS_CANARY) -o canary $<

pie: auth_overflow.c
	gcc $(CFLAGS_PIE) -o pie $<

nocanary: auth_overflow.c
	gcc $(CFLAGS_NOCANARY) -S -masm=intel -o nocanary.s $<
	gcc $(CFLAGS_NOCANARY) -masm=intel -Wa,-adhln $< > nocanary.lst
	gcc $(CFLAGS_NOCANARY) -o nocanary $<

overflow_example: overflow_example.c
	gcc  -m32  -g -Fdwarf -fno-pie  -fno-stack-protector -o overflow_example overflow_example.c

clean:
	rm -f  *.s *.lst canary nocanary overflow_example a.out  pie
	rm -f *~
