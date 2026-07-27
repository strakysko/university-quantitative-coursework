package Administration;

import java.io.PrintStream;
import java.util.Locale;
import java.util.Scanner;
import ui.UIAuxiliaryMethods;

public class Administration {
	// Name : Dávid Straka
	// Assignment : Administration
	// Date : October 29, 2020

	final static int UPPER_BOUND_FOR_6_MINUS = 6;
	final static double LOWER_BOUND_FOR_6_MINUS = 5.5;
	final static int NUMBER_OF_MATCHES_FOR_UNDERSCORE = 0;
	final static int LOWER_BOUND_FOR_CARET = 20;
	
	PrintStream out;

	Administration() {
		out = new PrintStream(System.out);
	}
	
	void calculateFinalGrade(String nameAndGrades) {
		Scanner nameAndGradesScanner = new Scanner(nameAndGrades);
		nameAndGradesScanner.useDelimiter("_");
		
		String nameOfAStudent = nameAndGradesScanner.next();
		String gradesOfAStudent = nameAndGradesScanner.next();
		
		out.printf("%s has an average of ", nameOfAStudent);
		printFinalGrade(gradesOfAStudent);
	}
	
	void printFinalGrade(String grades) {
		double averageGrade = calculateAverageGrade(grades);
		
		if (LOWER_BOUND_FOR_6_MINUS <= averageGrade && averageGrade < UPPER_BOUND_FOR_6_MINUS) {
			out.printf("6-\n");
		} else {
			double finalGrade = ((int) (averageGrade*2 + 0.5))/2.0; //rounds an average grade to the nearest half
			out.printf("%.1f\n", finalGrade);
		}
	}
	
	double calculateAverageGrade(String grades) {
		Scanner gradesScanner = new Scanner(grades);

		int sumOfGrades = 0;
		int numberOfGrades = 0;
		
		while (gradesScanner.hasNext()) {
			sumOfGrades += gradesScanner.nextInt();
			numberOfGrades += 1;
		}

		return (double) sumOfGrades / numberOfGrades;
	}

	void checkSimilarityScores(String scoresAndNames) {
		Scanner scoresAndNamesScanner = new Scanner(scoresAndNames);
		scoresAndNamesScanner.useDelimiter(";");

		String scoresOfSimilarity = scoresAndNamesScanner.next();
		plotScores(scoresOfSimilarity);
		
		if (scoresAndNamesScanner.hasNext()) {
			String studentsUnderInvestigation = scoresAndNamesScanner.next();
			printNamesOfStudents(studentsUnderInvestigation);
		} else {
			out.printf("\tNo matches found\n");
		}
	}

	void plotScores(String scoresOfSimilarity) {
		Scanner scoresScanner = new Scanner(scoresOfSimilarity);
		scoresScanner.useDelimiter("=");
		
		out.printf("\t");

		while (scoresScanner.hasNext()) {
			int numberOfMatchingPrograms = scoresScanner.nextInt();

			if (numberOfMatchingPrograms == NUMBER_OF_MATCHES_FOR_UNDERSCORE) {
				out.printf("_");
			} else if (numberOfMatchingPrograms < LOWER_BOUND_FOR_CARET) {
				out.printf("-");
			} else {
				out.printf("^");
			}
		}
		
		out.printf("\n");
	}
	
	void printNamesOfStudents(String studentsUnderInvestigation) {
		Scanner namesOfStudentsScanner = new Scanner(studentsUnderInvestigation);
		namesOfStudentsScanner.useDelimiter(",");
		
		while (namesOfStudentsScanner.hasNext()) {
			String studentUnderInvestigation = namesOfStudentsScanner.next();
			out.printf("\t%s\n", studentUnderInvestigation);
		}
	}
	
	void start() {
		Scanner in = UIAuxiliaryMethods.askUserForInput().getScanner();

		while (in.hasNext()) {
			calculateFinalGrade(in.nextLine());
			checkSimilarityScores(in.nextLine());
		}
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new Administration().start();
	}
}