#include <stdio.h>
#include <math.h>

float avgFinder(float current[10][10], int i, int j);
void gridPrinter(float current[10][10]);

int main (void){

	// two multidimensional arrays
	float first[10][10];
	float second[10][10];

	// values for tracking
	int i;
	int j;
	int z = 0;

	// values for assigning the boundaries, set by user
	float top;
	float right;
	float bottom;
	float left;

	// values for max. iterations and e, set by user
	int iterations;
	float e;
	
	// current tracks which table is current, first or second
	// accurate states if the difference values are all below the epsilon value
	// difference represents the difference between values in grids "first" and "second"
	int current = 1;
	int accurate = 0;
	float difference;

	// sets the two grid interiors to zero
	for(i=1;i<9;i++){
		for(j=1;j<9;j++){
			first[i][j] = 0;
			second[i][j] = 0;
		}
	}

	// prompt user for iteration #, make sure it's greater than 0
	// return if incorrect (assignment instructions)
	printf("Set the max number of iterations\n");
	while( ((scanf("%d",&iterations))!=1) || (iterations <= 0) ){
		printf("Sorry, enter a positive integer.\n");
		return 0;
	}

	// prompt user for epsilon value, between .001 and .1
	// return if incorrect (assignment instructions)
	printf("Set the error value, between .1 and .001\n");
	while( ((scanf("%f",&e))!=1) || (e < .001) || (.10000001 < e) ){
		printf("Sorry, enter a value between .1 and .001\n");
		return 0;
	}
	
	// user sets the values for top, right, bottom and left
	// return if incorrect (assignment instructions)
	printf("Enter the boundary numbers, in order of top, right, bottom and left.\n");
	while( ((scanf("%f",&top))!=1) || ((scanf("%f",&right))!=1) || ((scanf("%f",&bottom))!=1) || ((scanf("%f",&left))!=1)){
		printf("Sorry, enter an correct value.\n");
		return 0;
	}

	//sets the boundaries to the user-determined values
	for(i=0;i<10;i++){
		first[0][i] = top;
		second[0][i] = top;
		first[i][9] = right;
		second[i][9] = right;
		first[9][i] = bottom;
		second[9][i] = bottom;
		first[i][0] = left;
		second[i][0] = left;
	}
	
	// loop until z meets iterations, or until the differences are below epsilon
	while((z < iterations) && (accurate == 0)){
		
		accurate = 1;

		// assigns the avg. values from the current grid to a new grid
		// switching back and forth between first and second
		switch(current){
			case 1:
				for(i=1;i<9;i++){
					for(j=1;j<9;j++){
						second[i][j] = avgFinder(first, i, j);
						// if abs. value of the difference is greater than e, not yet accurate
						difference = fabsf(first[i][j] - second[i][j]);
						if(difference > e){
							accurate = 0;
						}
					}
				}
				
				if(accurate == 1){
					printf("Epsilon is: %f\n", e);
					printf("Number of iterations needed: %d\n", ++z);
					gridPrinter(second);
				}

				current = 2;
				break;
			// same thing, but now move from second to first
			case 2:
				for(i=1;i<9;i++){
					for(j=1;j<9;j++){
						first[i][j] = avgFinder(second, i, j);
						difference = fabsf(first[i][j] - second[i][j]);
						if(difference > e){
							accurate = 0;
						}
					}
				}

				if(accurate == 1){
					printf("Epsilon is: %f\n", e);
					printf("Number of iterations needed: %d\n", ++z);
					gridPrinter(first);
				}

				current = 1;
				break;	
			default:
				break;
		}

		// increase z
		z++;
	}

	// message and print if it failed to converge
	if (accurate == 0){
		printf("Failed to converge.\n");
		if (current = 1){
			gridPrinter(second);
		} else {
			gridPrinter(first);
		}
	}
	
	// return
	return 0;
}

// used to find the average of positions around a point
float avgFinder(float current[10][10], int i, int j){
	// the value that will be added and then averaged
	float x;
	x = current[i-1][j] + current[i][j+1] + current[i+1][j] + current[i][j-1];
	x = x/4;
	return x;
}

// used to print a grid
void gridPrinter(float current[10][10]){
	int i;
	int j;
	for(i=0;i<10;i++){
		for(j=0;j<10;j++){
			printf("%.2f ",current[i][j]);
		}
		printf("\n");
	}
}
