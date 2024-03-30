CFLAGS = -m32 -fno-PIC -Wall
LDFLAGS = -m32 -no-pie
BINARIES = cast_op_precedence signed_unsigned_char_int signed_unsigned_print negative_overflow

.PHONY: all clean

all: $(BINARIES)

$(BINARIES): %: %.o

: %.o: %.c

clean:
	-rm -f *~ $(BINARIES) $(BINARIES:=.o)
