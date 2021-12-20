ASM=as
ASMFLAGS=--32
CC=gcc
CFLAGS=-m32 -fno-pie
MAKEFLAGS=--silent

build: checker

check:
	./check.sh

checker: checker.o bonus_at_t.o
	$(CC) $(CFLAGS) $^ -o $@
 
bonus_at_t.o: bonus_at_t.S
	$(CC) -c $(CFLAGS) $^

checker.o: checker.c
	$(CC) -c $(CFLAGS) $^

copy:
	if [ -f ../../bonus_at_t.S ]; then cp ../../bonus_at_t.S .; else cp ../bonus_at_t.S .; fi

clean:
	rm checker *.o