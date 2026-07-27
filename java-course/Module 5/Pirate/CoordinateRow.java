package Pirate;

public class CoordinateRow {
	static final int MAX_NUMBER_OF_COORDINATES = 100;

	Coordinate[] coordinates;
	int numberOfCoordinates;

	CoordinateRow() {
		coordinates = new Coordinate[MAX_NUMBER_OF_COORDINATES];
		numberOfCoordinates = 0;
	}
	
	void addInFront(CoordinateRow row) {
		for(int i = row.numberOfCoordinates - 1; i >= 0; i--) {
			addInFront(row.coordinates[i]);
		}
	}
	
	void addInFront(Coordinate coordinate) {
		for(int i = numberOfCoordinates; i > 0; i--) {
			coordinates[i] = coordinates[i - 1];
		}

		coordinates[0] = coordinate;
		numberOfCoordinates++;
	}

	void addBehind(CoordinateRow row) {
		for(int i = 0; i < row.numberOfCoordinates; i++) {
			addBehind(row.coordinates[i]);
		}
	}
	
	void addBehind(Coordinate coordinate) {
		coordinates[numberOfCoordinates] = coordinate;
		numberOfCoordinates++;
	}
}