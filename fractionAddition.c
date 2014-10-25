#include <stdio.h>

struct fraction {
	int num;
	int den;
};

int main (void) {
	
	// structures
	struct fraction first;
	struct fraction second;
	struct fraction answer;
	
	// counter for finding the new denominator
	int counter = 2;
	
	// get fractions from user
	// don't worry about zeros or negs in the denom (assignment instructions)
	printf("Please input the numerator and denominator of fraction 1\n");
	scanf("%d %d",&first.num, &first.den);

	printf("Please input the numerator and denominator of fraction 2\n");
	scanf("%d %d",&second.num, &second.den);
	
	// find the new denominator
	// the first "counter" value that both denominators go into with no remainder
	while((counter % first.den != 0) || (counter % second.den != 0)){
		counter++;
	}

	// updated numerators
	// new denom / old denom, times the old numerator
	first.num = first.num * (counter/first.den);
	second.num = second.num * (counter/second.den);

	// new numerator is the addition of the two new numerators
	// new denom is the same as the counter
	answer.num = first.num + second.num;
	answer.den = counter;

	// reduce fraction down to smallest amount
	// while counter is greater than 0...
	// if counter goes into both numerator and denom with remainder 0
	// set new values to numerator and denom divided by counter
	counter = answer.num;
	while(counter > 0){
		if(answer.num % counter == 0 && answer.den % counter == 0){
			answer.num = answer.num / counter;
			answer.den = answer.den / counter;
			break;
		}
		counter--;
	}

	// print for user
	printf("The new fraction is: %d/%d\n",answer.num, answer.den);

	return 0;	
}
