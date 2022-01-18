CFLAGS=-m32

run: no-inline inline
	./no-inline
	./inline

no-inline: no-inline.c
	gcc $(CFLAGS) -o no-inline no-inline.c

inline: inline.c
	gcc $(CFLAGS) -o inline inline.c

clean:
	rm -f no-inline no-inline_op inline inline_op
