

### flags.asm
compile and play in gdb


### asymmetrical.c

-(-128 ) = -128 

C does not check flags, which may lead to bugs.
stdlib abs function behaves the same

### abs.cpp 

The same situation in C++ with std::abs 


### do_not_mix.c 

Easy to oversee bugs when mixing signed and unsigned.
Always heed compiler warnings!


### print_flags.c 
flags calculator 

For signed/unsigned operations, watch flags C(arry), O(verflow), S(ign).

Presence of a C/O flag means result is in the allowed interval. 

Absence of a C/O flag means the operation is within the allowed interval. 

0x2 + 0x2 
0xff + 1
0xff + 0xff
0xfe + 7
0x7f + 0x81 vs. 0x7f + 1
0x7f + 0x7f vs 0x7f + 0x80
xe0 - 0xcd
0x0 - 0x20
0x12 - 0x20
0x78 + 0x8
0x80 + 0x80
0x80 + 0xff



##### Exercises for C(arry) and O(verflow) - find a pair that activates:
* none 
* only C
* only O
* both 

##### Find examples to fill the following table: 

| S | C | O | op1  | +/- | op2 |
|:--|:--|:--|:-----|:----|:----|
| 0 | 0 | 0 | 0x1  | +   | 0x1 |
| 0 | 0 | 1 |      |     |     |
| 0 | 1 | 0 | 0xff | +   | 0x1 |
| 0 | 1 | 1 |      |     |     |
| 1 | 0 | 0 |      |     |     |
| 1 | 0 | 1 |      |     |     |
| 1 | 1 | 0 |      |     |     |
| 1 | 1 | 1 |      |     |     |




