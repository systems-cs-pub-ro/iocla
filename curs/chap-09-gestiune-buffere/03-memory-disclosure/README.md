* memory_disclosure.c
  - show the stack, identify all elements
  - run several times, explain the similarities & differences
  - disable aslr #echo 0 >    /proc/sys/kernel/randomize_va_space
  - enable aslr #echo 2 >    /proc/sys/kernel/randomize_va_space
  - prove that buf[6] is the return address (objdump -d)
  - prove that buf[5] is old RBP (gdb, b main, r, p/x $rbp)

* reader.c
  - practice reading values from the stack
  - 0..6, the same as in previous example (memory_disclosure.c)
  - what is at buf[-1]
  - what is at buf[-2]
  - what is at buf[-3]
  - what is at buf[-4]
  - homework: call  disclosure_target from another f(), and find variables of f()
