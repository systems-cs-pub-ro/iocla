Run commands below to investigate:

```
gcc -m32 -c -o sum.o sum.c
gcc -fno-PIC -c -o sum-no-pic.o sum.c
gcc -m32 -c -o main.o main.c
gcc -fno-PIC -c -o main-no-pic.o main.c

nm sum.o
nm sum-no-pic.o
nm -D sum.o
nm -D sum-no-pic.o

cp sum.o sum-stripped.o
strip sum-stripped.o
nm sum-stripped.o   # no symbols

readelf --sections sum-no-pic.o
readelf --sections sum.o # additional relocation sections

readelf --relocs sum-no-pic.o
readelf --relocs sum.o # additional relocations

readelf --symbols sum-stripped.o # no symbols
readelf --sections sum-stripped.o # fewer sections

gcc -o exec main.o sum.o
gcc -no-pie -o exec-no-pie main-no-pic.o sum-no-pic.o
gcc -static -no-pie -o exec-no-pie-static main-no-pic.o sum-no-pic.o

gcc -o exec-test main.o sum-stripped.o # error

cp exec exec-stripped
strip exec-stripped

nm exec
nm exec-stripped
nm -D exec
nm -D exec-stripped
nm -D exec-no-pie
nm -D exec-no-pie-static

readelf --relocs exec
readelf --relocs exec-no-pie
readelf --relocs exec-no-pie-static
```
