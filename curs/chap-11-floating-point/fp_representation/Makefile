CC = cc
STACK_FLAGS = -Wl,-z,noexecstack
LD = cc -m64 -g -no-pie $(STACK_FLAGS)
BINARIES = fp-m64 fp-m64-O2

all: $(BINARIES)

fp-m64-O2: fp_representation.c
	$(CC) -m64 -O2 $(STACK_FLAGS) -o $@ $^
	$(CC) -m64 -O2 -S -masm=intel -o fp-m64-O2.s $<

fp-m64: fp_representation.c
	$(CC) -m64 $(STACK_FLAGS) -o $@ $^
	$(CC) -m64 -S -masm=intel -o fp-m64.s $<

clean:
	rm -f $(BINARIES) *.s
	rm -f *~

.PHONY: all clean
