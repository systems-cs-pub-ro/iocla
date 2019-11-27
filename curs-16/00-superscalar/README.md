
* check speecd of the processor and number of cores 
 # cat /proc/cpuinfo | grep MHz
    cpu MHz		: 1600.020
  expect to be able to sustain 1.6*10^9 instructions / second 

* count instructions in the repeat loop
  read the source 
  use objdump -d to understand that there are 10^10 instructions in total 

* rdtsc counts clock ticks 

* notice the group of 4 instruction whic atre independent and can therefore be run simultaneously on different ALUs 

* experiment with different instructions to see whether they are parallelized or not
