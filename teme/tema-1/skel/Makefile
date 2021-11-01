build:
	gcc tema1.c -g -o tema
run:
	valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --logfile=memCheck
	./tema
	rm tema
run_without_valgrind:
	./tema < input.txt
	rm tema

clean:
	rm tema

checker:
	sudo python3 checker.py
