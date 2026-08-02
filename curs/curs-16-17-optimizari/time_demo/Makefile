all: clk rdtscp

clk: clk.c
	gcc -O3 -m64 -Wall clk.c -o clk

rdtscp: rdtscp.c
	gcc -O3 -m64 -Wall rdtscp.c -o rdtscp

papi: papi.c
	gcc -O3 -Wall papi.c -I$(PAPI_DIR) -L$(PAPI_DIR) -o papi -lpapi

clean:
	rm -f clk rdtscp papi
