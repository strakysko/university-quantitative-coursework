package Pyramid;

import java.util.Locale;
import java.io.PrintStream;

public class Pyramid {
	// Name : Dávid Straka
	// Assignment : Pyramid
	// Date : September 29, 2020
	
	static final int SCREEN_WIDTH = 80, NUMBER_OF_PYRAMID_LEVELS = 15;
	static final char FIRST_CHARACTER_IN_PYRAMID = 'a';
	
	PrintStream out;
	
	Pyramid() {
		out = new PrintStream(System.out);
	}
	
	void printPyramid(int screenWidth, int numberOfPyramidLevels, char firstCharacterInPyramid) {
		
		for (int i = 0; i < numberOfPyramidLevels; i++) {
			String messageToBePrinted = "";
			
			// prints gaps in a line
			for (int j = 0; j < screenWidth / 2 - i; j++) {
				messageToBePrinted += ' ';
			}
			
			// prints identical letters in a line
			for (int j = 0; j <= 2 * i; j ++) {
				messageToBePrinted += (char) (firstCharacterInPyramid + i);
			}
				
			out.printf("%s\n", messageToBePrinted);
		}
	}
	
	void start() {		
		printPyramid(SCREEN_WIDTH, NUMBER_OF_PYRAMID_LEVELS, FIRST_CHARACTER_IN_PYRAMID);
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Pyramid().start();
	}
}