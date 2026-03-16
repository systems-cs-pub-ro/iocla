CFLAGS = -fno-PIC -Wall
LDFLAGS = -no-pie
BINARIES = cast_op_precedence signed_unsigned_char_int signed_unsigned_print negative_overflow

.PHONY: all clean

all: $(BINARIES)

$(BINARIES): %: %.o

: %.o: %.c

clean:
	-rm -f *~ $(BINARIES) $(BINARIES:=.o)
