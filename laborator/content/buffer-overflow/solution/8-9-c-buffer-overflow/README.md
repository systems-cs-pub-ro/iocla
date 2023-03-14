# Ex 8-9 explained 

In do_overflow.asm:
   - line 32 -> sexy_var is at ebp-16
   - line 41 -> start reading buffer at ebp-89
   - 89 - 16 = 73 of 'A'
   - and 0x5541494D written in little endian mode

For 9, when running objdump, in main:
   - 650 and 74b are must see lines and around them