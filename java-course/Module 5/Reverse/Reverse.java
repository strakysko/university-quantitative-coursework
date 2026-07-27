package Reverse;

import java.io.PrintStream;
import java.util.Locale;
import java.util.Scanner;

public class Reverse {
	
	// I was trying to use the class IntRow
	PrintStream out;
	
	Reverse() {
		out = new PrintStream(System.out);
	}
	
	IntRow defineRow(String lineOfNumbers) {
		Scanner lineScanner = new Scanner(lineOfNumbers);
		IntRow row = new IntRow();
		
		while (lineScanner.hasNext()) {
			row.add(lineScanner.nextInt());
		}
		
		return row;
	}
	
	void printReversed(IntRow row) {
		for (int i = row.numberOfElements - 1; i >= 0; i--) {
			out.printf("%d ", row.elements[i]);
		}
		
		out.printf("\n");
	}
	
	void printLargestNumber(IntRow row1, IntRow row2) {
		out.printf("Largest number of row 1: %d\n", row1.largestElement());
		out.printf("Largest number of row 2: %d\n", row2.largestElement());
		out.printf("The largest number is in row %d.", row1.largestElement() > row2.largestElement() ? 1 : 2);
	}
	
	void start() {
		Scanner in = new Scanner("5 8 2 1\n-100 100 200");
		
		IntRow firstRow = defineRow(in.nextLine());
		IntRow secondRow = defineRow(in.nextLine());
		
		printReversed(firstRow);
		printReversed(secondRow);
		
		printLargestNumber(firstRow, secondRow);
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Reverse().start();
	}
}
