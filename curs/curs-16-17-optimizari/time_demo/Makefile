all: clk rdtscp papi

clock: clk.c
	gcc -O3 -m32 -Wall clk.c -o clk

clk: clock
	./clk

readtscp: rdtscp.c
	gcc -O3 -m32 -Wall rdtscp.c -o rdtscp

rdtscp: readtscp
	./rdtscp

papi_bin: papi.c
	gcc -O3 -Wall papi.c -I$(PAPI_DIR) -L$(PAPI_DIR) -o papi_bin -lpapi

papi: papi_bin
	./papi_bin

clean:
	rm -f clk rdtscp papi_bin
