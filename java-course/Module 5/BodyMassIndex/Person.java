package BodyMassIndex;

public class Person {
	String firstName, lastName;
	char sex;
	double height;
	int weight;
	
	Person(String firstName, String lastName, char sex, double height, int weight) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.sex = sex;
		this.height = height;
		this.weight = weight;
	}
	
	double calculateBMI() {
		return weight / (height * height);
	}
}