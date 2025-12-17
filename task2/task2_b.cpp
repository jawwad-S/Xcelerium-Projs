#include <iostream>
using namespace std;

int main()
{
	int a = 54;
	int *p0 = &a;
	int **p1 = &p0;

	cout << " var val: "<<a<<endl;
	cout << " p0  val: "<<*p0<<endl;
	cout <<" p1 val: "<<*p1<<endl;

	cout<<"addrs of a: "<<&a<<endl;
	cout << "addrs in p0: "<<p0<<endl;
	cout<< "addrs in p1: " << p1<<endl;


}
