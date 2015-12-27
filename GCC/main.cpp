#include <iostream>
#include "MyClass.h"
using namespace std;

int main() {
  cout << "hi, there!" << endl;
  
  MyClass m;
  int x = m.DoubleMyStuff(10);
  cout << x << endl;
}
