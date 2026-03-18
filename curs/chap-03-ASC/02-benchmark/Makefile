
# Compiler and flags
CC          = gcc
C_FLAGS_32  = -O2 -g -m32  # optimise, include debug info, target 32-bit ABI
C_FLAGS_64  = -O2 -g -m64  # optimise, include debug info, target 64-bit ABI

# Build all four executables: C and inline-ASM variants for both 32 and 64 bit
all: c32.out asm32.out c64.out asm64.out


# 32-bit targets 

# Compile the benchmark harness (main) as a 32-bit object
mult16m_32.o: mult16m.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS_32))
	$(CC) -c $(C_FLAGS_32) -o $@ $<

# Compile the pure-C multiply implementation as a 32-bit object
mult16c_32.o: mult16c.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS_32))
	$(CC) -c $(C_FLAGS_32) -o $@ $<

# Compile the 32-bit inline-ASM multiply implementation
# (uses mult16inline32.c which restricts to 32-bit registers)
mult16inline_32.o: mult16inline32.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS_32))
	$(CC) -c $(C_FLAGS_32) -o $@ $<

# Link 32-bit inline-ASM binary: harness + 32-bit inline-ASM multiply
asm32.out: mult16m_32.o mult16inline_32.o
	$(CC) $(C_FLAGS_32) -o $@ $^

# Link 32-bit pure-C binary: harness + pure-C multiply
c32.out: mult16m_32.o mult16c_32.o
	$(warning OUT=$@ IN=$^)
	$(CC) $(C_FLAGS_32) -o $@ $^


#  64-bit targets 

# Compile the benchmark harness (main) as a 64-bit object
mult16m_64.o: mult16m.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS_64))
	$(CC) -c $(C_FLAGS_64) -o $@ $<

# Compile the pure-C multiply implementation as a 64-bit object
mult16c_64.o: mult16c.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS_64))
	$(CC) -c $(C_FLAGS_64) -o $@ $<

# Compile the 64-bit inline-ASM multiply implementation
# (uses mult16inline.c which uses 64-bit registers: %rdx, movslq, shlq, addq)
mult16inline_64.o: mult16inline.c
	$(warning CC=$(CC) FLAGS=$(C_FLAGS_64))
	$(CC) -c $(C_FLAGS_64) -o $@ $<

# Link 64-bit inline-ASM binary: harness + 64-bit inline-ASM multiply
asm64.out: mult16m_64.o mult16inline_64.o
	$(CC) $(C_FLAGS_64) -o $@ $^

# Link 64-bit pure-C binary: harness + pure-C multiply
c64.out: mult16m_64.o mult16c_64.o
	$(warning OUT=$@ IN=$^)
	$(CC) $(C_FLAGS_64) -o $@ $^


# Remove all generated object files and executables
clean:
	rm -f *.o
	rm -f *.out *~
