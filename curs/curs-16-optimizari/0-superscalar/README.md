
* check speecd of the processor and number of cores 
 # cat /proc/cpuinfo | grep MHz
    cpu MHz		: 1600.020
 # ./test_freq 
    2712307880
  expect to be able to sustain 2.7*10^9 instructions / second 
  Why the difference? Processors work at several speeds to save power. Use the high one

* count instructions in the repeat loop
  read the source 
  use objdump -d to understand that there are 10^10 instructions in total 

* rdtsc counts clock ticks 

* notice the group of 4 instruction which are independent and can therefore be run simultaneously on different ALUs 
  obtain approx 4 instructions / cycle :) 

* experiment with different instructions to see whether they are parallelized or not


