# Finds factorial of a number                   FACT_MIPS.ASM
#
# Objective: Computes factorial of an integer. 
#            To demonstrate recursive procedures.
#     Input: Requests an integer N from keyboard.
#    Output: Outputs N!
#
#    a0 - used to pass N
#    v0 - used to return result
#
###################### Data segment ##########################
      .data
prompt:	
      .asciiz     "Please enter a positive integer: \n"
out_msg:	
      .asciiz     "The factorial is: "
error_msg:	
      .asciiz     "Sorry! Not a positive number.\nTry again.\n "
newline:
      .asciiz     "\n"

###################### Code segment ##########################

      .text
      .globl main
main:
      la    $a0,prompt         # prompt user for input
      li    $v0,4
      syscall

try_again:
      li    $v0,5              # read the input number into $a0
      syscall
      move  $a0,$v0

      bgez  $a0,num_OK
      la    $a0,error_msg      # write error message
      li    $v0,4
      syscall
      b     try_again

num_OK:
      jal   fact
      move  $s0,$v0

      la    $a0,out_msg        # write output message
      li    $v0,4
      syscall

      move  $a0,$s0            # output factorial
      li    $v0,1             
      syscall

      la    $a0,newline        # write newline
      li    $v0,4
      syscall

      li    $v0,10             # exit
      syscall

#-----------------------------------------------------------
# FACT receives N in $a0 and returns the result in $v0
# It uses recursion to find N!
#-----------------------------------------------------------
fact:
      subu  $sp,$sp,4          # allocate stack space
      sw    $ra,0($sp)         # save return address

      bgt   $a0,1,one_up       # recursion termination
      li    $v0,1
      b     return
 
one_up:
      subu  $a0,$a0,1          # recurse with (N-1)
      jal   fact
      addu  $a0,$a0,1
      mulou $v0,$a0,$v0        # $v0 := $a0*$v0

return:
      lw    $ra,0($sp)         # restore return address
      addu  $sp,$sp,4          # clear stack space
      jr    $ra
