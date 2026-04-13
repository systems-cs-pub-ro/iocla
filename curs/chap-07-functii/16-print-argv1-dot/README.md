# Print argv[1] Only If It Starts with a Dot

This demo extends `15-print-argv1` by adding a check on the first character of `argv[1]`.
After verifying `argc == 2`, the program compares the first byte of `argv[1]` against the `.` (dot) character.
If `argv[1]` does not start with `.`, an informational message is printed.
Otherwise the full string is printed.
This shows how to dereference a pointer and compare a single byte in assembly (`cmp [rsi], byte '.'`).

## Contents

Directory contents are:

* `print_argv1_dot.asm`: Implementation in NASM assembly for x86_64
* `Makefile`: Makefile to build the assembly file into the `print_argv1_dot` binary executable (ELF)
* `README.md`: This file

## Build

To build the example, use:

```console
make
```

This creates the `print_argv1_dot` binary executable (ELF).

## Run

To run the binary with a dot-prefixed argument, use:

```console
./print_argv1_dot .hidden
```

Running the command above prints:

```text
argv[1] is .hidden
```

Running with an argument that does not start with `.`:

```console
./print_argv1_dot hello
```

Prints:

```text
argv[1] doesn't start with a . (dot)
```