package Othello2;

import java.util.Locale;
import java.util.Scanner;
import java.io.PrintStream;

public class Othello2 {
	// Name : Dávid Straka
	// Assignment : Othello 2
	// Date : September 15, 2020
	
	static final int SEC_IN_MIN = 60;
	static final int MIN_IN_HOUR = 60;
	static final int MILLISEC_IN_SEC = 1000;
	
	PrintStream out;
	
	Othello2() {
		out = new PrintStream(System.out);
	}
	
	void start() {
		Scanner in = new Scanner(System.in);
		
		out.printf("Enter the time the black player thought: ");
		int thinkingTime1 = in.nextInt();
		
		out.printf("Enter the time the white player thought: ");
		int thinkingTime2 = in.nextInt();
		
		int seconds;
		
		if (thinkingTime1 > thinkingTime2) {
			seconds = thinkingTime1 / MILLISEC_IN_SEC;
		} else {
			seconds = thinkingTime2 / MILLISEC_IN_SEC;
		}
		
		int minutes = seconds / SEC_IN_MIN;
		seconds -= SEC_IN_MIN * minutes;
		int hours = minutes / MIN_IN_HOUR;
		minutes -= MIN_IN_HOUR * hours;
	
		out.printf("The time the human player has spent thinking is: %02d:%02d:%02d.", hours, minutes, seconds);
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Othello2().start();
	}
}