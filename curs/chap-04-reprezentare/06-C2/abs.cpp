#include <iostream>

int main()

{
  int x = 0x80000000;
  std::cout << std::abs(x) << std::endl;
  if(std::abs(x) < 0){
    std::cout << "x is negative";  
  }
}

/* 
   The situation is the same with java.Math.abs() 
   and possibly other languages as well
*/
