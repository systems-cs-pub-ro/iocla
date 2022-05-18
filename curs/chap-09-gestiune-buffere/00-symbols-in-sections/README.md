
1. linker error: anas are implicitly global, no problem with stanas. How to fix?

2. `nm sections | grep an `
Notice several variables with the same name. How is the linker resolving? 

0804c020 d ana
0804c02c D ana
0804c02e d bogdan
0804c022 D bogdan
0804c024 d dan
0804c01c D __dso_handle
0804a00c r stan
0804c034 b stana
0804c03c b stana

3. explain both values for bogdan
