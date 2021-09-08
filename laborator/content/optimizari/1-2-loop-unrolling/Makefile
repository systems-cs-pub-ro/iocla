
OPTFLAGS=-O3
CFLAGS=-m32


all: normal_loop normal_loop_op unrolled_loop unrolled_loop_op

normal_loop: normal_loop.c
	gcc $(CFLAGS) -o normal_loop normal_loop.c

normal_loop_op: normal_loop.c
	gcc $(CFLAGS) $(OPTFLAGS) -o normal_loop_op normal_loop.c

unrolled_loop: unrolled_loop.c
	gcc $(CFLAGS) -o unrolled_loop unrolled_loop.c

unrolled_loop_op: unrolled_loop.c
	gcc $(CFLAGS) $(OPTFLAGS) -o unrolled_loop_op unrolled_loop.c


clean:
	rm -f normal_loop normal_loop_op unrolled_loop unrolled_loop_op
	rm -f *.o *~

.PHONY: run
run:
	./normal_loop
	./normal_loop_op
	./unrolled_loop
	./unrolled_loop_op
