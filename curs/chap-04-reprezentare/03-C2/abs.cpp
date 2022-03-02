#include <iostream>

int main()

{
  int x = 0x80000000, modx;

  modx = std::abs(x);
  std::cout << "x = " << modx << std::endl;
  if(modx < 0){
    std::cout << "|x| is negative\n";  
  }
}

/* 
   The situation is the same with java.Math.abs(), and matlab;
   python3 works well - extends representation as needed
*/
