package SecondSmallest;

import java.util.Locale;
import java.util.Scanner;
import java.io.PrintStream;

public class SecondSmallest {
	// Name : Dávid Straka
	// Assignment : SecondSmallest
	// Date : September 17, 2020
	
	PrintStream out;
	
	SecondSmallest() {
		out = new PrintStream(System.out);
	}
	
	void start() {
		Scanner in = new Scanner(System.in);
		
		int smallest = in.nextInt();
		int secondSmallest = in.nextInt();
		
		while (in.hasNext()) {
			int nextInteger = in.nextInt();
			
			if (nextInteger <= smallest) {
				secondSmallest = smallest;
				smallest = nextInteger;
			} else if (nextInteger <= secondSmallest) {
				secondSmallest = nextInteger;
			}
		}
		
		out.printf("The second smallest number is:%d", secondSmallest);
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new SecondSmallest().start();
	}
}