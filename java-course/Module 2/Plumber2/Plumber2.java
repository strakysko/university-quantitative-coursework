package Plumber2;

import java.util.Locale;
import java.util.Scanner;
import java.io.PrintStream;

public class Plumber2 {
	// Name : Dávid Straka
	// Assignment : Plumber 2
	// Date : September 15, 2020
	
	static final double CALL_OUT_COST = 16.00;
	
	PrintStream out;
	
	Plumber2() {
		out = new PrintStream(System.out);
	}
	
	void start() {
		Scanner in = new Scanner(System.in);
		
		out.printf("Enter the hourly wages: ");
		double hourlyWages = in.nextDouble();
		
		out.printf("Enter the number of hours worked: ");
		int numOfBillableHours = (int) (in.nextDouble() + 0.5);
		
		double totalCost = CALL_OUT_COST + hourlyWages * numOfBillableHours;
		out.printf("The total cost of this repair is: \u20ac%.2f\n", totalCost);
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Plumber2().start();
	}
}