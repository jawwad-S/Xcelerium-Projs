#include <iostream>
using namespace std;

int main()
{
	int n;
	cout << "Enter size of arr: "<<endl;
	cin>> n;
	int *arr = new int[n];

	for(int i = 0; i < n; i++)
	{
		cout<<"Enter val in arr["<<i<<"]: ";
		cin>>arr[i];
	}

                cout<<"Enter vals are: "<<endl;

	for(int i = 0; i<n; i++)
	{
		//cout<<"Enter vals are: "<<endl;
		cout<<"arr["<<i<<"]: ";
		cout <<arr[i];
	}

	char y;
	cout<<"Do you want to free memory? (Y/N)"<< endl;
	cin >> y;
	if(y == 'y' || y == 'Y'){
		delete[] arr;
		cout<< "Memory Freed Successfully";}
	else if (y == 'n' || y == 'N')
		cout <<" Memory not freed";
}
