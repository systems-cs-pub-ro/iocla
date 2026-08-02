# Call Assembly Function (with Header File)

This demo is identical to `06-sum2-from-c-to-as` but uses a header file to declare the assembly function.
This is the recommended practice: keep function declarations in a `.h` file and `#include` it wherever the function is called.

## Contents

* `add.asm`: Assembly implementation of `add()` that receives two numbers and returns their sum
* `add.h`: Header file that declares the `add()` function
* `main.c`: C `main` that includes `add.h`, calls `add()`, and prints the result
* `Makefile`: Builds the `sum2` binary from all source files
* `README.md`: This file

## Build

```console
make
```

This creates the `sum2` binary.

## Run

```console
./sum2
```

Output:

```text
Sum is: 5
```

## Understand

`add.h` contains only the function declaration:

```c
long add(long a, long b);
```

`main.c` includes it instead of repeating the declaration:

```c
#include "add.h"

long result = add(2, 3);
```

This approach scales well: when the signature of `add()` changes, only `add.h` needs to be updated — all callers automatically pick up the new declaration on the next build.
It also prevents mismatches between the declaration used in each C file that calls the function.
