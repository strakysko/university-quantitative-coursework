package Pirate;

import java.io.PrintStream;
import java.util.Locale;
import java.util.Scanner;
import ui.UIAuxiliaryMethods;

public class Pirate {

	final static int COEFFICIENT_FOR_SHIFTING_X_COORDINATE = 1;

	PrintStream out;

	Pirate() {
		out = new PrintStream(System.out);
	}

	CoordinateRow solvePuzzle(Scanner in) {
		CoordinateRow solution = new CoordinateRow();
		in.useDelimiter("=");
		
		int i = 0;
		while (in.hasNext()) {
			CoordinateRow coordinateSubrow = readCoordinateRow(in.next());
			
			if (i % 2 == 0) {
				solution.addInFront(coordinateSubrow);
			} else {
				solution.addBehind(coordinateSubrow);
			}
			
			i++;
		}
		
		return solution;
	}

	CoordinateRow readCoordinateRow(String row) {		
		CoordinateRow result = new CoordinateRow();
		Scanner rowScanner = new Scanner(row);

		while (rowScanner.hasNext()) {
			Coordinate coordinate = readAndShiftCoordinate(rowScanner.next());
			result.addBehind(coordinate);
		}

		return result;
	}
	
	Coordinate readAndShiftCoordinate(String coordinate) {
		Scanner coordinateScanner = new Scanner(coordinate);
		coordinateScanner.useDelimiter(",");

		int x = coordinateScanner.nextInt() + COEFFICIENT_FOR_SHIFTING_X_COORDINATE;
		int y = coordinateScanner.nextInt();
		
		return new Coordinate(x, y);
	}

	void printCoordinates(CoordinateRow coordinates) {
		for (int i = 0; i < coordinates.numberOfCoordinates; i++) {
			out.printf("%d,%d\n", coordinates.coordinates[i].x, coordinates.coordinates[i].y);
		}
	}
	
	void start() {
		Scanner in = UIAuxiliaryMethods.askUserForInput().getScanner();
		
		CoordinateRow solution = solvePuzzle(in);
		printCoordinates(solution);
	}

	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Pirate().start();
	}
}