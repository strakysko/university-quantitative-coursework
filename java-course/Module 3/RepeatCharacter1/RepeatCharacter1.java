package RepeatCharacter1;

import java.util.Locale;
import java.util.Scanner;
import java.io.PrintStream;

public class RepeatCharacter1 {
	// Name : Dávid Straka
	// Assignment : RepeatCharacter1
	// Date : September 29, 2020
	
	static final char CHARACTER_TO_BE_PRINTED = '!';
	
	PrintStream out;
	
	RepeatCharacter1() {
		out = new PrintStream(System.out);
	}
	
	void printCharacterRepeatedly(int numberOfPrintsOfCharacter) {
		
		for (int i = 0; i < numberOfPrintsOfCharacter; i++) {
			out.printf("%s", CHARACTER_TO_BE_PRINTED);
		}
	}
	
	void start() {
		Scanner in = new Scanner(System.in);
		
		int numberOfPrintsOfCharacter = in.nextInt();
		printCharacterRepeatedly(numberOfPrintsOfCharacter);
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new RepeatCharacter1().start();
	}
}