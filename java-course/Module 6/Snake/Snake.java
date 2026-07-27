package Snake;

import java.util.Scanner;

import ui.Event;
import ui.SnakeUserInterface;
import ui.UserInterfaceFactory;
import ui.UIAuxiliaryMethods;

public class Snake {
	final static int WIDTH = 32, HEIGHT = 24, INITIAL_FRAMES_PER_SECOND = 3;

	SnakeUserInterface ui;
	double framesPerSecond;
	CoordinateRow snake;
	String direction;
	Coordinate apple;
	CoordinateRow walls;
	int changesPerRefresh;
	
	Snake() {
		ui = UserInterfaceFactory.getSnakeUI(WIDTH, HEIGHT);
		framesPerSecond = INITIAL_FRAMES_PER_SECOND;
		snake = new CoordinateRow(WIDTH * HEIGHT);
		walls = new CoordinateRow(WIDTH * HEIGHT);
		changesPerRefresh = 0;
	}
	
	void makeTheInitialSetUp(Scanner in) {
		in.useDelimiter("=");
		
		setInitialSnake(in.next());
		direction = in.next();
		buildWalls(in.next());
		
		placeNewApple();
		
		ui.showChanges();
	}
	
	void setInitialSnake(String coordinates) {
		Scanner coordinatesScanner = new Scanner(coordinates);
		
		while (coordinatesScanner.hasNext()) {
			Coordinate newSnakeCoordinate = new Coordinate(coordinatesScanner.nextInt(), 
					coordinatesScanner.nextInt());
			
			snake.addBehind(newSnakeCoordinate);
			ui.place(newSnakeCoordinate.column, newSnakeCoordinate.row, ui.SNAKE);
		}
	}
	
	void buildWalls(String coordinates) {
		Scanner coordinatesScanner = new Scanner(coordinates);
		
		while (coordinatesScanner.hasNext()) {
			Coordinate newWallCoordinate = new Coordinate(coordinatesScanner.nextInt(), 
					coordinatesScanner.nextInt());
			
			walls.addBehind(newWallCoordinate);
			ui.place(newWallCoordinate.column, newWallCoordinate.row, ui.WALL);
		}
	}
	
	void placeNewApple() {
		do {
			apple = new Coordinate (UIAuxiliaryMethods.getRandom(0, WIDTH - 1),
					UIAuxiliaryMethods.getRandom(0, HEIGHT - 1));
		}
		while(coordinateIsFull(apple));
		
		ui.place(apple.column, apple.row, ui.FOOD);
	}
	
	boolean coordinateIsFull(Coordinate coordinate) {
		for (int i = 0; i < snake.numberOfCoordinates; i++) {
			if (snake.coordinates[i].column == coordinate.column 
					&& snake.coordinates[i].row == coordinate.row) {
				return true;
			}
		}

		for (int i = 0; i < walls.numberOfCoordinates; i++) {
			if (walls.coordinates[i].column == coordinate.column 
					&& walls.coordinates[i].row == coordinate.row) {
				return true;
			}
		}
		
		return false;
	}
	
	void processEvent(Event event) {
		if (event.name.equals("alarm") && event.data.equals("refresh")) {
			moveSnake();
			changesPerRefresh = 0;
		} else if (event.name.equals("arrow")) {
			if (changesPerRefresh == 0)	{
				changeDirection(event.data);
				changesPerRefresh ++;
			}
		}		
		
		ui.showChanges();
	}
	
	void changeDirection(String arrow) {
		if (direction.equals("L") && !(arrow.equals("R"))) {
			direction = arrow;
		} else if (direction.equals("R") && !(arrow.equals("L"))) {
			direction = arrow;
		} else if (direction.equals("U") && !(arrow.equals("D"))) {
			direction = arrow;
		} else if (direction.equals("D") && !(arrow.equals("U"))) {	
			direction = arrow;
		}
	}
	
	void moveSnake() {
		Coordinate newHead = createNewHeadOfSnake();
		
		if (coordinateIsFull(newHead)) {
			UIAuxiliaryMethods.showMessage("Game Over");
			System.exit(0);
		}
		
		snake.addInFront(newHead);
		ui.place(newHead.column, newHead.row, ui.SNAKE);
		
		checkForApple(newHead);
		}
	
	Coordinate createNewHeadOfSnake() {
		Coordinate currentHead = snake.coordinates[0];		
		
		if (direction.equals("R")) {
			return shiftCoordinate(new Coordinate(currentHead.column + 1, currentHead.row));
		} else if (direction.equals("L")) {
			return shiftCoordinate(new Coordinate(currentHead.column - 1, currentHead.row));
		} else if (direction.equals("U")) {
			return shiftCoordinate(new Coordinate(currentHead.column, currentHead.row - 1));
		} else {
			return shiftCoordinate(new Coordinate(currentHead.column, currentHead.row + 1));
		}
	}
	
	Coordinate shiftCoordinate(Coordinate coordinate) {
		
		if (coordinate.column < 0) {
			return new Coordinate(WIDTH - 1, coordinate.row);
		} else if (coordinate.column == WIDTH) {
			return new Coordinate(0, coordinate.row);
		} else if (coordinate.row < 0) {
			return new Coordinate(coordinate.column, HEIGHT - 1);
		} else if (coordinate.row == HEIGHT) {
			return new Coordinate(coordinate.column, 0);		
		}
		
		return coordinate;
	}
	
	void checkForApple(Coordinate newHead) {
		if (!(apple.column == newHead.column && apple.row == newHead.row)) {
			snake.numberOfCoordinates--;
			ui.place(snake.coordinates[snake.numberOfCoordinates].column, 
					snake.coordinates[snake.numberOfCoordinates].row, ui.EMPTY);
		} else {
			placeNewApple();
		}
	}

	void start() {
		Scanner in = UIAuxiliaryMethods.askUserForInput().getScanner();
		ui.setFramesPerSecond(framesPerSecond);

		makeTheInitialSetUp(in);

		while (true) {
			Event event = ui.getEvent();
			processEvent(event);
		}
	}

	public static void main(String[] args) {
		new Snake().start();
	}
}