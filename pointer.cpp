#include<iostream>
using namespace std;

int main()
{
	int k = 5;
	int* j;

	j = &k;

	cout<<"Val of variable: "<< *j <<" Val of addrs: "<<j;
	return 0;
}
