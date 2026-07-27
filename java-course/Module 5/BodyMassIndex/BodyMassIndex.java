package BodyMassIndex;

import java.io.PrintStream;
import java.util.Locale;
import java.util.Scanner;

public class BodyMassIndex {
	
	PrintStream out;
	
	BodyMassIndex() {
		out = new PrintStream(System.out);
	}

	void assessHealth(String inputLine) {
		Scanner lineScanner = new Scanner(inputLine);
		
		Person person = readPerson(lineScanner);
		printAssessment(person);
	}
	
	Person readPerson(Scanner lineScanner) {
		String firstName = lineScanner.next();
		String lastName = lineScanner.next();
		char sex = lineScanner.next().charAt(0);
		double height = lineScanner.nextDouble();
		int weight = lineScanner.nextInt();
		
		return new Person(firstName, lastName, sex, height, weight);
	}

	void printAssessment(Person person) {
		double BMI = person.calculateBMI();
		
		out.printf("%s %s's BMI is %.1f and is %s.\n", person.sex == 'V' ? "Mrs." : "Mr.", person.lastName, BMI, isHealthy(BMI) ? "healthy" : "unhealthy");
	}	
	
	boolean isHealthy(double BMI) {
		return 18.5 < BMI && BMI < 25;
	}
	
	void start() {
		Scanner in = new Scanner("Dean Johnson M 1.78 83\nSophia Miller V 1.69 60");

		while(in.hasNext()) {
			assessHealth(in.nextLine());
		}
	}

	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new BodyMassIndex().start();
	}
}