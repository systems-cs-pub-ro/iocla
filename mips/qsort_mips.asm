# Sorting numbers using quick sort              QSORT_MIPS.ASM
#
# Objective: Sorts an array of integers using quick sort. 
#            Uses recursion.
#     Input: Requests integers from the user; 
#            terminated by entering a zero.
#    Output: Outputs the sorted integer array.
#
#    a0 - start of array
#    a1 - beginning of (sub)array
#    a2 - end of (sub)array
#
###################### Data segment ##########################
      .data
prompt:	
      .ascii     "Please enter integers. \n"
      .asciiz    "Entering zero terminates the input. \n"
output_msg:	
      .asciiz     "The sorted array is: \n"
newline:
      .asciiz     "\n"
array:
      .word       200

###################### Code segment ##########################

      .text
      .globl main
main:
      la    $a0,prompt         # prompt user for input
      li    $v0,4
      syscall

      la    $t0,array
read_more:
      li    $v0,5              # read a number
      syscall
      sw    $v0,($t0)          # store it in the array
      beqz  $v0,exit_read
      addu  $t0,$t0,4
      b     read_more
exit_read:
      # prepare arguments for procedure call
      la    $a1,array          # a1 = lo pointer
      move  $a2,$t0
      subu  $a2,$a2,4          # a2 = hi pointer
      jal   qsort             

      la    $a0,output_msg     # write output message
      li    $v0,4
      syscall

      la    $t0,array
write_more:
      lw    $a0,($t0)          # output sorted array
      beqz  $a0,exit_write
      li    $v0,1             
      syscall
      la    $a0,newline        # write newline message
      li    $v0,4
      syscall
      addu  $t0,$t0,4
      b     write_more
exit_write:

      li    $v0,10             # exit
      syscall

#------------------------------------------------------------
# QSORT receives pointer to the start of (sub)array in a1 and 
# end of (sub)array in a2.
#------------------------------------------------------------
qsort:
      subu  $sp,$sp,16         # save registers
      sw    $a1,0($sp)
      sw    $a2,4($sp)
      sw    $a3,8($sp)
      sw    $ra,12($sp)

      ble   $a2,$a1,done       # end recursion if hi <= lo

      move  $t0,$a1
      move  $t1,$a2

      lw    $t5,($t1)          # t5 = xsep

lo_loop:                            #
      lw    $t2,($t0)               # 
      bge   $t2,$t5,lo_loop_done    # LO while loop
      addu  $t0,$t0,4               #
      b     lo_loop                 #
lo_loop_done:

      subu  $t1,$t1,4          # hi = hi-1
hi_loop:
      ble   $t1,$t0,sep_done        #
      lw    $t3,($t1)               #
      blt   $t3,$t5,hi_loop_done    # HI while loop
      subu  $t1,$t1,4               #
      b     hi_loop                 #
hi_loop_done:

      sw     $t2,($t1)              #
      sw     $t3,($t0)              # x[i]<=>x[j]
      b      lo_loop                #

sep_done:
      move  $t1,$a2                 #
      lw    $t4,($t0)               #
      lw    $t5,($t1)               # x[i] <=>x[hi]
      sw    $t5,($t0)               #
      sw    $t4,($t1)               #

      move  $a3,$a2            # save HI for the second call
      move  $a2,$t0                 #
      subu  $a2,$a2,4               # set hi as i-1
      jal   qsort

      move  $a1,$a2                 #
      addu  $a1,$a1,8               # set lo as i+1
      move  $a2,$a3                 
      jal   qsort          
done:
      lw    $a1,0($sp)         # restore registers
      lw    $a2,4($sp)
      lw    $a3,8($sp)
      lw    $ra,12($sp)
      addu  $sp,$sp,16

      jr    $ra


