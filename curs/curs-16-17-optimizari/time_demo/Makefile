all: clk rdtscp papi

clk: clk.c
	gcc -O3 -m32 -Wall clk.c -o clk

rdtscp: rdtscp.c
	gcc -O3 -m32 -Wall rdtscp.c -o rdtscp

papi: papi.c
	gcc -O3 -Wall papi.c -I$(PAPI_DIR) -L$(PAPI_DIR) -o papi -lpapi

clean:
	rm -f clk rdtscp papi
