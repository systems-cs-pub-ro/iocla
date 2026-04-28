FILES = overflow_example.c auth_overflow.c
CFLAGS_CANARY    = -fno-pie -g -masm=intel -fstack-protector
CFLAGS_NOCANARY  = -fno-pie -g -masm=intel -fno-stack-protector
CFLAGS_PIE       = -g -masm=intel -fstack-protector

all: overflow_example canary nocanary pie

canary: auth_overflow.c
	gcc $(CFLAGS_CANARY)   -S -o canary.s $<
	gcc $(CFLAGS_CANARY)   -Wa,-adhln $< > canary.lst
	gcc $(CFLAGS_CANARY)   -o canary $<

pie: auth_overflow.c
	gcc $(CFLAGS_PIE) -o pie $<

nocanary: auth_overflow.c
	gcc $(CFLAGS_NOCANARY) -S -o nocanary.s $<
	gcc $(CFLAGS_NOCANARY) -Wa,-adhln $< > nocanary.lst
	gcc $(CFLAGS_NOCANARY) -o nocanary $<

overflow_example: overflow_example.c
	gcc -fno-pie -g -masm=intel -fno-stack-protector -o overflow_example overflow_example.c

clean:
	rm -f *.s *.lst canary nocanary overflow_example a.out pie
	rm -f *~
