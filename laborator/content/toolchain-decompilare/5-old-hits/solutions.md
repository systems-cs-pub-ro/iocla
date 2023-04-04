# Solution

Using Ghidra to decompile the executable, we find that the password, an int, is 
secret + 1337, where secret is a randomly generated number using time(NULL) as 
a seed. This means that the password changes every time we run the program. 
Knowing this, we have two ways to solve the puzzle.

# 1. By using GDB

A breakpoint will be set after the secret variable has been initialised using 
GDB. After running the executable, the secret value will be found using the 
`print (int) secret` command. The correct value has been found if a non-zero 
integer is printed. We can, then, manually compute the password by adding 
1337 to this number. After that, the `continue` command will be used, so that 
the program asks for our password, which we will enter.

# 2. Using another executable

Because the value returned by time(NULL) is measured in seconds, there is a 
good chance we can generate the same "random" value just before running the 
executable. A second program will be created, that generates a random number 
based on time, adds 1337 to it and prints it to stdout. After that, we can pipe 
this executable to our given executable.

