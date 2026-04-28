
1. Linker error: `ana` is implicitly global in both translation units. Fix by adding `static`.

2. `nm sections | grep an`
   Notice several variables with the same name. How is the linker resolving?
   Addresses are now 64-bit (16 hex digits). Example output:

   0000000000404030 d ana
   0000000000404040 D ana
   0000000000404042 d bogdan
   0000000000404038 D bogdan
   000000000040403c d dan
   0000000000404020 D __dso_handle
   0000000000402010 r stan
   0000000000404048 b stana
   0000000000404050 b stana

   (exact addresses will vary; use `nm sections | sort` to see layout)

3. Explain both values for `bogdan`. Why does the linker pick one over the other?

4. Compare section placement using `readelf -S sections` and `objdump -t sections`.
   Note that 64-bit ELF sections are at higher addresses than 32-bit ELF.

