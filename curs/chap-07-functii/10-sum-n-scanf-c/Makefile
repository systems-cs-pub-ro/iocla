CC = gcc
CPPFLAGS = -U_FORTIFY_SOURCE
CFILES = sum_n_scanf.c
OBJS = $(CFILES:.c=.o)
BINARIES = $(CFILES:.c=)
CFLAGS = -fno-PIC -fcf-protection=none -fno-stack-protector -O1 -fno-inline -fno-omit-frame-pointer -Wall -Wno-unused-result -g
LD = gcc
LDFLAGS = -no-pie

.PHONY: all clean

all: $(BINARIES)

# Pattern rule: build .o from .c
%.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

# Pattern rule: build binary from .o
%: %.o
	$(LD) $(LDFLAGS) -o $@ $<

clean:
	-rm -f $(OBJS)
	-rm -f $(BINARIES)
	-rm -f *~
