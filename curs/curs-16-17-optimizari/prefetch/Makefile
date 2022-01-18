all: prefetch no-prefetch

prefetch: prefetch.c
	gcc -DDO_PREFETCH -o prefetch -std=c11 -O3 prefetch.c

no-prefetch: prefetch.c
	gcc -o no-prefetch -std=c11 -O3 prefetch.c

clean:
	rm -f prefetch no-prefetch
