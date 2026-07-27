package Snake;

public class CoordinateRow {

	Coordinate[] coordinates;
	int numberOfCoordinates;

	CoordinateRow(int length) {
		coordinates = new Coordinate[length];
		numberOfCoordinates = 0;
	}
	
	void addInFront(Coordinate coordinate) {
		for(int i = numberOfCoordinates; i > 0; i--) {
			coordinates[i] = coordinates[i - 1];
		}

		coordinates[0] = coordinate;
		numberOfCoordinates++;
	}
	
	void addBehind(Coordinate coordinate) {
		coordinates[numberOfCoordinates] = coordinate;
		numberOfCoordinates++;
	}
}