#include <iostream>

using namespace std;

int main()
{
	int a = 1, b = 2;
	int c = 0;

	for (int i = 0; i < 10; i++)
	{
		c += (a*i + b*i);
		cout << "Value of c = " << c << endl;
	}

	return 0;
}
