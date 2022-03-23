#include <iostream>

int i = 0x80000000, modi;
long long  l = 0x8000000000000000, modl;

int main()
{
  modi = std::abs(i);
  modl = std::abs(l);
  std::cout << "i = " << i << "; |i| = " << modi << std::endl;
  if(modi < 0){
    std::cout << "|i| is negative\n";  
  }
  std::cout << "l = " << l << "; |l| = " << modl << std::endl;
  if(modl < 0){
    std::cout << "|l| is negative\n";  
  }
}

/* 
   The situation is the same with java.Math.abs();
   python3 works well - extends int representation as needed
*/
