
* buffer-in-struct.c
			- members in struct are at consecutive addresses

* buffer-in-struct-all.c 
			- that is true for data declared: 1. on the stack, 2. in .bss, 3. in .data 4. on heap
			- verify using objdump -x buffer_in_struct_all.o 
			- c_data in .data; c_bss in .bss
			- where is c? 
			- where is c_heap?
			- where is *c_heap?
			
* buffer_instruct_func.c
			- the same as buffer_in_struct_all.c
		   
		   
