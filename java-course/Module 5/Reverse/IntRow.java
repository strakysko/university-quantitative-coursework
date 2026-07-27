package Reverse;

public class IntRow {
	static final int MAX_NUMBER_OF_ELEMENTS = 20;
	
	int[] elements;
	int numberOfElements;
	
	IntRow() {
		elements = new int[MAX_NUMBER_OF_ELEMENTS];
		numberOfElements = 0;
	}

	void add(int number) {
		elements[numberOfElements] = number;
		numberOfElements += 1;
	}
	
	int largestElement() {
		int largest = Integer.MIN_VALUE;
		
		for (int i = 0; i < numberOfElements; i++) {
			if (elements[i] > largest) {
				largest = elements[i];
			}
		}
		
		return largest;
	}
}