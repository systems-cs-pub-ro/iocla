CC = gcc
CFLAGS = -Wall -g

build: main.o
	$(CC) -o main $^

main.o: main.c
	$(CC) $(CFLAGS) -c $^

run: build
	./main

checker:
	./checker.py

check: build
	valgrind --leak-check=full \
         --show-leak-kinds=all \
         --track-origins=yes \
         --verbose \
         --log-file=valgrind-out.txt \
         ./main

clean:
	rm -f valgrind-out.txt
	rm -f *.o main

.PHONY: clean check checker run build
