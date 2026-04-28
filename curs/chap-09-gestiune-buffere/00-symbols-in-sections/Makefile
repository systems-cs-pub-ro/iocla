CFLAGS = -Wall -W -g -fno-PIC -fno-stack-protector -Wno-unused-variable -Wno-unused-function -Wno-unused-const-variable
LDFLAGS = -no-pie

.PHONY: all clean

all: sections

sections: sections.o helper.o

sections.o: sections.c

helper.o: helper.c

clean:
	-rm -f sections.o sections helper.o helper
	-rm -f *~
