package Events;

import java.util.Scanner;

import ui.Event;
import ui.SnakeUserInterface;
import ui.UserInterfaceFactory;

public class Events {

	final static int WIDTH = 40;
	final static int HEIGHT = 30;

	SnakeUserInterface ui;

	Events() {
		ui = UserInterfaceFactory.getSnakeUI(WIDTH, HEIGHT);
	}

	void processEvent(Event event) {
		ui.printf("%s - %s\n", event.name, event.data);

		if (event.name.equals("click")) {
			buildWall(event.data);
		} else if (event.data.equals("Space")) { 
			ui.clear();
			ui.showChanges();
		}
	}

	void buildWall(String data) {
		Scanner dataScanner = new Scanner(data);
		
		ui.place(dataScanner.nextInt(), dataScanner.nextInt(), ui.WALL);
		ui.showChanges();
	}
	
	void start() {
		
		while (true) {
			Event event = ui.getEvent();
			processEvent(event);
		}
	}

	public static void main(String[] args) {
		new Events().start();
	}
}