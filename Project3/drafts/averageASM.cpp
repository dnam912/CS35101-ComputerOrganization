#include <iostream>

using namespace std;

int main() {

    int integer;
    float decimals;
    float inputNumber;
    int counting;

    // ERROR!!! - make counting values unstable
    // int intPart[counting];
    // int decPart[counting];

    int sumIntPart = 0;
    int sumDecPart = 0;
    int sumCarry = 0;
    
    cout << "Enter a number for counting: ";
    cin >> counting;

    // DYNAMIC MEMORY //
    int* intPart = new int[counting];
    int* decPart = new int[counting];


    int tempInt;
    for (int i = 0; i < counting; i++) {
        cout << "Enter a 3 digit decimal d.dd: ";
        cin >> inputNumber; // 4.12

        tempInt = inputNumber * 100; // 412
        integer = ((int) tempInt / 100) % 10; // integer = 4
        decimals = (int) tempInt % 100;       // decimals in int = 12

        intPart[i] = integer;
        decPart[i] = decimals;
    }

    int j = 0;
    while (j != counting) {

        sumIntPart += intPart[j];
        sumDecPart += decPart[j];

        ++j;
    }

    sumCarry = (sumDecPart / 100) % 10;
    sumIntPart += sumCarry;
    sumDecPart -= (sumCarry * 100);
    
    float average = 0.0;
    average = ((float)sumIntPart / counting) + ( ((float)sumDecPart / counting) / 100);


    cout << "\nSum of Decimal values: " << sumIntPart << "." << sumDecPart << endl;
    cout << "\nThe Mean Average is: " << average << endl;

    return 0;
}

