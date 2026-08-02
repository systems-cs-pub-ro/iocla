CC = gcc
CPPFLAGS = -U_FORTIFY_SOURCE
CFILES = main.c
OBJS = $(CFILES:.c=.o)
BINARY = measure
CFLAGS = -fno-PIC -fcf-protection=none -fno-stack-protector -O1 -fno-inline -fno-omit-frame-pointer -Wall -Wno-unused-result -g
LD = gcc
LDFLAGS = -no-pie

.PHONY: all clean

all: $(BINARY)

%.o: %.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(BINARY): $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $^

clean:
	-rm -f $(OBJS)
	-rm -f $(BINARY)
	-rm -f *~
