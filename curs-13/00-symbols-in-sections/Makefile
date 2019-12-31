CFLAGS = -Wall -W -Wno-unused-variable -Wno-unused-function -Wno-unused-const-variable -g -m32 -fno-PIC -fno-stack-protector
LDFLAGS = -no-pie -m32

.PHONY: all clean

all: sections

sections: sections.o helper.o

sections.o: sections.c

helper.o: helper.c

clean:
	-rm -f sections.o sections helper.o helper
	-rm -f *~
