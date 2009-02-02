using System;
using System.Collections;

public class PrintEnvironment {
    public static void Main(string[] args) {
	IDictionary variables = Environment.GetEnvironmentVariables();
    
	ICollection variableNames = variables.Keys;
    
	foreach (string variableName in variableNames) {
	    Console.WriteLine("{0}={1}", variableName, variables[variableName]);
	}
    }
}
