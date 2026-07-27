package Manny;

import java.util.Locale;
import java.util.Scanner;
import java.io.PrintStream;

public class Manny {
	// Name : Dávid Straka
	// Assignment : Manny
	// Date : September 17, 2020
	
	static final double MIN_DONATION = 50.00; // euro // feedback: even clearer name e.g. MINIMUM_DONATION_TO_STOP_ASKING
	
	PrintStream out;
	
	Manny() {
		out = new PrintStream(System.out);
	}
	
	void start() {
		Scanner in = new Scanner(System.in);
		
		double donation;
		
		do {
			out.printf("Enter the amount you want to donate: \n"); 
			donation = in.nextDouble();
		} while (donation < MIN_DONATION);
		
		out.printf("Thank you very much for your contribution of %.2f euro.", donation);
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Manny().start();
	}
}