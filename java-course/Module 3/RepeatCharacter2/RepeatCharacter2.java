package RepeatCharacter2;

import java.util.Locale;
import java.util.Scanner;
import java.io.PrintStream;

public class RepeatCharacter2 {
	// Name : Dávid Straka
	// Assignment : RepeatCharacter2
	// Date : September 29, 2020
	
	static final char FIRST_CHARACTER_TO_BE_PRINTED = '!', SECOND_CHARACTER_TO_BE_PRINTED = ',';
	
	PrintStream out;
	
	RepeatCharacter2() {
		out = new PrintStream(System.out);
	}
	
	void printCharacterRepeatedly(int numberOfPrintsOfCharacter, char characterToBePrinted) {
		String messageToBePrinted = "";
	
		for (int i = 0; i < numberOfPrintsOfCharacter; i++) {
			messageToBePrinted += characterToBePrinted;
		}
		
		out.printf("%s\n", messageToBePrinted);
	}
	
	void start() {
		Scanner in = new Scanner(System.in);
		
		int numberOfPrintsOfFirstCharacter = in.nextInt();
		printCharacterRepeatedly(numberOfPrintsOfFirstCharacter, FIRST_CHARACTER_TO_BE_PRINTED);
		
		int numberOfPrintsOfSecondCharacter = in.nextInt();
		printCharacterRepeatedly(numberOfPrintsOfSecondCharacter, SECOND_CHARACTER_TO_BE_PRINTED);
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new RepeatCharacter2().start();
	}
}