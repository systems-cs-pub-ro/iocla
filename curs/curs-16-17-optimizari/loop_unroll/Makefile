CFLAGS=-m32

run: normal_loop unrolled_loop
	./normal_loop
	./unrolled_loop

normal_loop: normal_loop.c
	gcc $(CFLAGS) -o normal_loop normal_loop.c

unrolled_loop: unrolled_loop.c
	gcc $(CFLAGS) -o unrolled_loop unrolled_loop.c

clean:
	rm -f normal_loop normal_loop_op unrolled_loop unrolled_loop_op
