# Writeup

- First use this command to scan the executable:
> ```Bash
> objdump -M intel -d break_this
> ```

- The binary reads from standar input the length of a buffer and the buffer using th function `read_buffer()`. The variable `n` is supposed to store the length of the buffer, `char buffer[64]` is the actual buffer. Because `fgets()` reads at most `n - 1` characters, we can set `n` to a value bigger than the actual buffer length, so an overflow is still possible.
- I will set `n` to a big enough value: `128`

- `magic_function()` is saved at `0x08048596`
- From the first 4 lines from `read_buffer()` we get that: `ebp` and `edi` get pushed on the stack, then the stack is extended by `0x54` = `84`
- So we must print `88 + 4 + 4 = 92` dummy characters `A` and then the address of `magic_function()` in little-endian encoding

> ``` Bash
> python2 -c 'print "128\n" + "A"*92 + "\x96\x85\x04\x08"' > payload
> ```