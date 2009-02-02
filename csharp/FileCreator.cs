using System;
using System.IO;

public class FileCreator {
    public static void Main(string[] args) {
	string file = args[0];
	
	if(File.Exists(file)) {
	    Console.WriteLine("File {0} exists with attributes {1}," +
			      "created at {2}", file, File.GetAttributes(file),
			      File.GetCreationTime(file));
	}
	else {
	    using(TextWriter writer = File.CreateText(file)) {
		writer.WriteLine("Greetings from Mono!");
	    }
	    File.SetAttributes(file,
			       File.GetAttributes(file) | FileAttributes.ReadOnly |
			       FileAttributes.Temporary);
	}
	
	using (TextReader reader = File.OpenText(file)) {
	    Console.WriteLine(reader.ReadToEnd());
	}
    }
}
