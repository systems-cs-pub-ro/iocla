# Ex 10 explained 

   - We can use Ghidra to disassemble the exec.
   - In main, number of arguments must be equal to 2 (one is the name of the executable file).
   - The argument is passed in the function check_string.

In check_string:
   - local_10 must be set to 0x4E305250 to call success() (carefully, use little endian)
   - local_10 is stored at stack - Ox10
   - Buffer is stored at stack - Ox30
   - So 32 (48 - 16) of 'A' and "\x50\x52\x30\x4E"