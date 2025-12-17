#include <iostream>
using namespace std;

class Account
{
	protected:
		int accountNumber = 0, balance = 0;

	public:
		int deposit(int a)
		{
			balance = balance+a;
			cout<<"New Balance: "<<balance<<endl;
			return balance;
		}
		virtual void  withdraw(int w)
		{
			balance = balance-w;
			cout<<"Current balance: "<<balance<<endl;
			//return balance;
		}
		int displayBalance(int accNo)
		{
			cout<<"Acc no, :"<<accNo<<endl;
			cout << "Account No:"<<accountNumber<<endl;
			cout<<"Current Balance: "<<balance<<endl;
			return balance;
		}
		
		int getBalance()
	       	{
		       	return balance; 
		}
   		 void setBalance(int b)
		 {
			 balance = b;
		 }

};


class SavingsAccount : public Account {
	public:
		void withdraw (int amnt) override
		{
			if(amnt>50000)
				cout<<"Withdraw Limit Exceed"<<endl;
			else 
			{
				cout << "Amount withdrawn: "<<endl;
				Account::withdraw(amnt);
			}
				
		}
};

class CurrentAccount : public Account {
	public:
		void withdraw (int amnt)
		{
			int charges = 10;	//10% charge
			int deduct;
			int newBal = getBalance();
			deduct = (amnt*charges)/100;
			cout <<"Amount witdrwn after charges: "<<amnt-deduct<<endl;
			setBalance(getBalance() - (amnt - deduct));
		}
};



int main()
{
	//deposit d;
	//withdraw w;
	//displayBalance b;
	Account a;
	SavingsAccount  s;
	CurrentAccount c;
	int i,j;
	cout<<"Class and Encapsulation Completed"<<endl;
	cout<<"Do you want to 1) Deposit, 2) Withdraw, 3) Check Balance"<<endl;
	cin >> i;
	switch (i) 
	{
		case 1:
			cout<<"Enter Amount: "<<endl;
			cin>> j;
			a.deposit(j);
			break;
		case 2:
			cout<<"Enter Amount: "<<endl;
			cin>>j;
			s.withdraw(j);
			break;
		case 3:
			cout<<"Enter account no. : "<<endl;
			cin>>j;
			a.displayBalance(j);
			break;
		default:
			cout<<"Enter correct option no.!"<<endl;
			break;
	}	
	//Abstraction
	
    Account* accounts[2];
    accounts[0] = new SavingsAccount();
    accounts[1] = new CurrentAccount();
    //
    int choice, amt;
    cout << "Choose Account Type: 1) Savings 2) Current" << endl;
    cin >> choice;
    
    Account* selected = accounts[choice - 1];
    
    selected->deposit(60000);
    selected->withdraw(30000);
    selected->displayBalance(123456);
    
    for(int i = 0; i < 2; i++)
        delete accounts[i];


	return 0;
}

			

