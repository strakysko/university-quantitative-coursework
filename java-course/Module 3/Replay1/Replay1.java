package Replay1;

import java.util.Locale;
import java.util.Scanner;
import ui.OthelloReplayUserInterface;
import ui.UIAuxiliaryMethods;
import ui.UserInterfaceFactory;

public class Replay1 {
	// Name : Dávid Straka
	// Assignment : Replay1
	// Date : October 9, 2020
	
	final static char LETTER_OF_THE_FIRST_COLUMN = 'a';

	OthelloReplayUserInterface ui;

	Replay1() {
		ui = UserInterfaceFactory.getOthelloReplayUI();
	}
	
	void showTheInitialBoard() {
		ui.place(3, 4, ui.BLACK);
		ui.place(4, 3, ui.BLACK);
		ui.place(3, 3, ui.WHITE);
		ui.place(4, 4, ui.WHITE);
		
		ui.showChanges();
	}
	
	void takeTurn(String nextLine) {
		Scanner line = new Scanner(nextLine);

		int colorOfAStone = (line.next().equals("black")) ? ui.BLACK : ui.WHITE;
		int waitingTime = line.nextInt();

		ui.wait(waitingTime);

		boolean move = (line.next().equals("move")) ? true : false;
		
		if (move) {
			char letterOfAColumn = line.next().charAt(0);
			int numberOfAColumn = letterOfAColumn - LETTER_OF_THE_FIRST_COLUMN;
			int numberOfARow = line.nextInt() - 1;
			
			ui.place(numberOfAColumn, numberOfARow, colorOfAStone);
			ui.showChanges();
		}
	}
	
	void start() {
		Scanner in = UIAuxiliaryMethods.askUserForInput().getScanner();
		
		showTheInitialBoard();
		
		while (in.hasNext()) {
			takeTurn(in.nextLine());
		}
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Replay1().start();
	}
}