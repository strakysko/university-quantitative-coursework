package Pizza;

import java.util.Locale;
import java.io.PrintStream;

public class Pizza {
	// Name : Dávid Straka
	// Assignment : Pizza
	// Date : September 29, 2020
	
	static final int NUMBER_OF_INGREDIENTS_MARIO = 10, SECOND_CHARACTER_TO_BE_PRINTED = ',';
	
	PrintStream out;
	
	Pizza() {
		out = new PrintStream(System.out);
	}
	
	int factorial(int x) {
		int y = 1;
		
		for (int i = 1; i <= x; i++ ) {
			y *= i;
		}
		
		return y;
	}
	
	void printCharacterRepeatedly(int numberOfPrintsOfCharacter, char characterToBePrinted) {
		String messageToBePrinted = "";
	
		for (int i = 0; i < numberOfPrintsOfCharacter; i++) {
			messageToBePrinted += characterToBePrinted;
		}
		
		out.printf("%s\n", messageToBePrinted);
	}
	
	void start() {
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Pizza().start();
	}
}