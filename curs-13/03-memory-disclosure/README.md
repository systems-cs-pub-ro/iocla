
* memory_disclosure.c 
  - show the stack, identify all elements 
  - run several times, explain the similarities & differences
  - prove that buf[6] is the return address (objdump -d) 
  - prove that buf[5] is old EBP (gdb, b main, r, p/x $ebp) 

* reader.c 
  - practice reading values from the stack
  - 0..6, the same as in previous example (memory_discclosure.c)
  - what is at buf[-1] ? local variable index
  - what is at buf[-2] ? (freed stack, old param for read_int)
  - what is at buf[-3] ? return location after read_int
  - what is at buf[-4] ? my current EBP(in disclose_target) - prove it; prove iot without gdb! 
  - what is at buf[-12]? 0, '2', '1', '-'
  - homework: call  disclosure_target from another f(), and find variables of f()
