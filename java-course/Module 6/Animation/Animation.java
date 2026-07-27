package Animation;

import ui.Event;
import ui.SnakeUserInterface;
import ui.UserInterfaceFactory;

public class Animation {
	
	final static int WIDTH = 3, HEIGHT = 3, INITIAL_FRAMES_PER_SECOND = 3;
	final static double ARROW_CHANGE_IN_FRAMES_PER_SECOND = 0.5;

	SnakeUserInterface ui;
	double framesPerSecond;
	int x,y;
	int movingObject;

	Animation() {
		ui = UserInterfaceFactory.getSnakeUI(WIDTH, HEIGHT);
		framesPerSecond = INITIAL_FRAMES_PER_SECOND;
		x = 0;
		y = 0;
		movingObject = ui.WALL;
	}
	
	void processEvent(Event event) {
		
		if (event.name.equals("alarm") && event.data.equals("refresh")) {
			processAlarm();
			
		} else if (event.name.equals("arrow") && event.data.equals("R")) {
			framesPerSecond += ARROW_CHANGE_IN_FRAMES_PER_SECOND;
			ui.setFramesPerSecond(framesPerSecond);
			
		} else if (event.name.equals("arrow") && event.data.equals("L")) {
			framesPerSecond -= ARROW_CHANGE_IN_FRAMES_PER_SECOND;
			ui.setFramesPerSecond(framesPerSecond);
			
		} else if (event.name.equals("letter") && event.data.equals("g")) {
			movingObject = (movingObject == ui.WALL) ? ui.SNAKE : ui.WALL;
			ui.showChanges();
		}
		
	}
	
	void processAlarm() {
		ui.place(x,y,ui.EMPTY);
		
		x++;
		
		if (x == WIDTH) {
			x = 0;
			y++;
			
			if (y == HEIGHT) {
				y = 0;
			}
		}
		
		ui.place(x, y, movingObject);
		ui.showChanges();
	}
	
	void start() {
		ui.setFramesPerSecond(framesPerSecond);
		
		while (true) {
			Event event = ui.getEvent();
			processEvent(event);
		}
	}

	public static void main(String[] args) {
		new Animation().start();
	}
}