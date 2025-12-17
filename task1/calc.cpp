#include <iostream>
using namespace std;

int main() 
{
	int a,b;
	char op;

	cout<<"////////// SIMPLE CALCULATOR //////////"<<endl;
	cout<<"ENTER 1st no: ";
	cin>> a;
	cout<<"ENTER 2nd no: ";
	cin>>b;
	cout <<"Enter op: ";
	cin>> op;

	switch(op)
	{
		case '+' : cout << a+b << endl; break;
		case '-' : cout << a-b;  break;
		case '/' : cout << a/b; break;
		case '*' : cout << a*b; break;
		default :  cout << "Enter Valid op!";
	}
	return 0;
}

