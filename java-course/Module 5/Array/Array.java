package Array;

import java.io.PrintStream;
import java.util.Locale;
import java.util.Scanner;

public class Array {
	
	final static int NUMBER_OF_INPUTS = 20;
	
	PrintStream out;
	
	Array() {
		out = new PrintStream(System.out);
	}
	
	void printReversed(Scanner in) {
		double[] numbers = createArray(in);
		
		for (int i = numbers.length - 1; i >= 0; i--) {
			out.printf("%f ", numbers[i]);
		}
	}
	
	double[] createArray(Scanner in) {
		double[] array = new double[NUMBER_OF_INPUTS];

		for (int i = 0; i < array.length; i++) {
			array[i] = in.nextDouble();
		}
		
		return array;
	}
	
	void start() {
		Scanner in = new Scanner(System.in);
		
		printReversed(in);
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Array().start();
	}
}