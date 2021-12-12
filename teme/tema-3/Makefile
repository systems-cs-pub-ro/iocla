MAKEFLAGS=--silent

all: run clean

run: checker

checker:
	./check_all.sh

clean:
	rm */checker/*.o
	rm */checker/checker
	rm */checker/*.asm
