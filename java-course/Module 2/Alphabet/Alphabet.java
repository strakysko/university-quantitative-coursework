package Alphabet;

import java.util.Locale;
import java.io.PrintStream;

public class Alphabet {
	// Name : Dávid Straka
	// Assignment : Alphabet
	// Date : September 17, 2020
	
	PrintStream out;
	
	static final char FIRST_LETTER = 'A';
	static final char LAST_LETTER = 'Z';
	
	Alphabet() {
		out = new PrintStream(System.out);
	}
	
	void start() {
		for (char c = FIRST_LETTER; c <= LAST_LETTER; c++) {
			out.printf("%c", c);
		}
	}

	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Alphabet().start();
	}
}