package Electronics;

import java.util.Locale;
import java.util.Scanner;
import java.io.PrintStream;

public class Electronics {
	// Name : Dávid Straka
	// Assignment : Electronics
	// Date : September 15, 2020
	
	static final double REDUCTION_PERCENTAGE = 15; // feedback: it is double, so write 15.00 instead of 15
	
	PrintStream out;
	
	Electronics() {
		out = new PrintStream(System.out);
	}
	
	void start() {
		Scanner in = new Scanner(System.in);
		
		out.printf("Enter the price of the first article: ");
		double price1 = in.nextDouble();
		
		out.printf("Enter the price of the second article: ");
		double price2 = in.nextDouble();
		
		out.printf("Enter the price of the third article: ");
		double price3 = in.nextDouble();
		
		double discount;
		
		if (price1 > price2 && price1 > price3) {
			discount = price1 * REDUCTION_PERCENTAGE / 100;
		} else if (price2 > price3) {
			discount = price2 * REDUCTION_PERCENTAGE / 100;
		} else {
			discount = price3 * REDUCTION_PERCENTAGE / 100;
		}
		
		double totalPrice = price1 + price2 + price3 - discount;
		out.printf("Discount: %.2f\nTotal: %.2f\n", discount, totalPrice);
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Electronics().start();
	}
}