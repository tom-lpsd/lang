using System;
using System.IO;

public class FileFinder {
    public static void Main(string[] args) {
	string filename = null;
	try {
	    filename = args[0];
	    using(StreamReader reader = File.OpenText(filename)) {
		string contents = reader.ReadToEnd();
	    }
	}
	catch(IndexOutOfRangeException e) {
	    Console.Error.WriteLine("No filename specified");
	    Environment.Exit(1);
	}
	catch(FileNotFoundException e) {
	    Console.Error.WriteLine("File \"{0}\" does not exist.", filename);
	    Environment.Exit(2);
	}
	catch(Exception e) {
	    Console.Error.WriteLine(e);
	    Environment.Exit(3);
	}
	finally {
	    Console.WriteLine("Done");
	}
    }
}
