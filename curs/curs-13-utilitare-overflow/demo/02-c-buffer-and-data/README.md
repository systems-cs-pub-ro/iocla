
* global_buffer.c
 Q: buf, type, and length are at consecutive locations... are they? 
 A: type and length are in .data, buf is in .bss
 $ nm ./global_buffer | sort
 
* stack_buffer.c
  - stack grows down, addresses grow up (textbook/slides picture)
  - &type == &buf[32]; &length == &buf[33]
  - &buf[34] == old EBP, &buf[35] == return somewhere outside main(), ...
  
* stack_buffer_char.c
  - stack grows down, addresses grow up (textbook/slides picture)
  - buf has 9 bytes, type and length 4 bytes each
  - buf[9] == lsb of type; type < 256 => other bytes of type are 0
  - buf[13] == lsb of length . . . 
  - buf[10] == sencond byte of type (little endian "lsb at lower address")
  - 55D = 0x47, type becomes 0x470B = 55*256 + 11 = 14091
  - watch the addresses of the variables on the stack - 4 aligned where possible
  
