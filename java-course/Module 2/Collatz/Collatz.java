package Collatz;

import java.util.Locale;
import java.util.Scanner;
import java.io.PrintStream;

public class Collatz {
	// Name : Dávid Straka
	// Assignment : Collatz
	// Date : September 17, 2020
	
	PrintStream out;
	
	Collatz() {
		out = new PrintStream(System.out);
	}
	
	void start() {
		Scanner in = new Scanner(System.in);
		
		out.printf("Enter a positive integer: ");
		int n = in.nextInt(); //feedback: have a variable name positiveInteger instead of n
		
		out.printf("The corresponding Collatz sequence is: %d ", n);
		
		while (n != 1) {
			if (n % 2 == 0) {
				n /= 2;
			} else {
				n = 3 * n + 1;
			}
			out.printf("%d ", n);
		}
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Collatz().start();
	}
}