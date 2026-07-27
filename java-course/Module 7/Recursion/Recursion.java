package Recursion;

import java.io.PrintStream;
import java.util.Scanner;

public class Recursion {
	
	PrintStream out;
	
	Recursion() {
		out = new PrintStream(System.out);
	}
	
	int numberOfDigits(int number) {
		if (number / 10 == 0) {
			return 1;
		}
		return numberOfDigits(number/10) + 1;
	}
	
	int fibonnaci(int n) {
		if (n == 0) {
			return 0;
		} else if (n == 1) {
			return 1;
		}
		
		return fibonnaci(n - 1) + fibonnaci(n - 2);
	}
	
	void reverse(Scanner input) {
		if (!input.hasNext()) {
			return;
		}
		
		int number = input.nextInt();
		reverse(input);
		
		out.printf("%d ", number);
	}
	
	double calculate(double x, int n) {
		return 0.0;
	}
	
	void removeSoftGemstones() {
		
	}
	
	int count(int[] r, int i, int a) {
		if (i == r.length) {
			return 0;
		}
		
		return (r[i] == a ? 1:0) + count(r,i+1,a);
	}
	
	void start() {
		int[] r = {1,12,1,1};
		int i = count(r, 0, 1);
		out.printf("%d",i);
	}
	
	public static void main(String[] args) {
		new Recursion().start();
	}
}