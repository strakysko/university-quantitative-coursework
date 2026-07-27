package NuclearPowerPlant;

import java.util.Locale;
import java.io.PrintStream;

public class NuclearPowerPlant {
	// Name : Dávid Straka
	// Assignment : NuclearPowerPlant
	// Date : September 29, 2020
	
	PrintStream out;
	
	NuclearPowerPlant() {
		out = new PrintStream(System.out);
	}
	
	void printWarningMessage() {
		out.printf("NUCLEAR CORE UNSTABLE!!!\n");
		out.printf("Quarantine is in effect.\n");
		out.printf("Surrounding hamlets will be evacuated.\n");
		out.printf("Anti-radationsuits and iodine pills are mandatory.\n\n");
	}
	
	void start() {		
		printWarningMessage();  // should i prefer a for a loop?
		printWarningMessage();
		printWarningMessage();
	}
	
	public static void main(String[] args) {
		Locale.setDefault(Locale.US);
		new NuclearPowerPlant().start();
	}
}