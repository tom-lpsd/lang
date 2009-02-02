using System;

public class Strings {
    public static void Main(string[] args) {
	string s1 = "a string!";
	string s2 = @"a string with \escaped characters,
including a carriage return";
	string s3 = new String('a', 4);
	string s4 = s3 + s1;
	string s5 = s4.Replace('a', 'b');

	Console.WriteLine(s1);
	Console.WriteLine(s2);
	Console.WriteLine(s3);
	Console.WriteLine(s4);
	Console.WriteLine(s5);
    }
}
