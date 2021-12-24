CFLAGS = -m32 -fno-PIC -Wall
LDFLAGS = -m32 -no-pie

.PHONY: all clean

all: one_var many_vars

one_var: one_var.o

one_var.o: one_var.c

many_vars: many_vars.o

many_vars.o: many_vars.c

clean:
	-rm -f *~
	-rm -f one_var.o one_var
	-rm -f many_vars.o many_vars
