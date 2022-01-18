all: profile

gprof_demo: gprof_demo.c
	gcc -O3 -Wall -std=c99 -pg gprof_demo.c -o gprof_demo

run: gprof_demo
	./gprof_demo

profile: run
	gprof gprof_demo gmon.out > profile_data.txt

clean:
	rm -f gprof_demo profile_data.txt gmon.out
