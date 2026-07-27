package Othello1;

import java.util.Locale;
import java.util.Scanner;
import java.io.PrintStream;

public class Othello1 {
	// Name : Dávid Straka
	// Assignment : Othello 1
	// Date : September 15, 2020
	
	static final int NUM_OF_SQUARES = 64;
	
	PrintStream out;
	
	Othello1() {
		out = new PrintStream(System.out);
	}
	
	void start() {
		Scanner in = new Scanner(System.in);
		
		out.printf("Enter the number of white pieces on the board: ");
		int numWhitePieces = in.nextInt();
		
		out.printf("Enter the number of black pieces on the board: ");
		int numBlackPieces= in.nextInt();
		
		double blackPercentageOfBoard = (double) numBlackPieces / NUM_OF_SQUARES * 100;
		double blackPercentageOfAllPieces = (double) numBlackPieces / (numBlackPieces + numWhitePieces) * 100;
		out.printf("The percentage of black pieces on the board is: %.2f%%\n", blackPercentageOfBoard);
		out.printf("The percentage of black pieces of all the pieces on the board is: %.2f%%\n", blackPercentageOfAllPieces);
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Othello1().start();
	}
}