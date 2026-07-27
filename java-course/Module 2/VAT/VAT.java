package VAT;

import java.util.Locale;
import java.util.Scanner;
import java.io.PrintStream;

public class VAT {
	// Name : Dávid Straka
	// Assignment : VAT
	// Date : September 15, 2020
	 
	static final double VAT_PERCENTAGE = 21.00;
	
	PrintStream out;
	
	VAT() {
		out = new PrintStream(System.out);
	}
	
	void start() {
		Scanner in = new Scanner(System.in);
		
		out.printf("Enter the price of an article including VAT: ");
		double priceWithVAT = in.nextDouble();
		
		double priceWithoutVAT = priceWithVAT / (100 + VAT_PERCENTAGE) * 100;
		out.printf("This article will cost %.2f euro without %.2f%% VAT.\n", priceWithoutVAT, VAT_PERCENTAGE);
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new VAT().start();
	}
}