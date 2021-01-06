all: test test_o1 test_o2 test_o3 test_unroll

test: test.c
	gcc -Wall -m32 -O0 -o test test.c

test_o1: test.c
	gcc -Wall -m32 -O1 -o test_o1 test.c

test_o2: test.c
	gcc -Wall -m32 -O2 -o test_o2 test.c

test_o3: test.c
	gcc -Wall -m32 -O3 -o test_o3 test.c

test_unroll: test.c
	gcc -Wall -funroll-loops -m32 -O3 -o test_unroll test.c

clean:
	rm -rf test test_o* test_unroll
