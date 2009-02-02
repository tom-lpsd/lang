using System;
using System.Collections;
using System.IO;
using System.Text.RegularExpressions;

public class ParseHosts {
    public static void Main(string[] args) {
	string filename;
	if (Environment.OSVersion.ToString().StartsWith("Unix")) {
	    filename = string.Format("{0}etc{0}hosts",
				     Path.DirectorySeparatorChar);
	}
	else {
	    filename = string.Format("{0}{1}drivers{1}etc{1}hosts",
				     Environment.GetFolderPath(Environment.SpecialFolder.System),
				     Path.DirectorySeparatorChar);
	}

	if(!File.Exists(filename)) {
	    Console.Error.WriteLine("{0} does not exists.", filename);
	    Environment.Exit(1);
	}

	string text;
	using (TextReader reader = File.OpenText(filename)) {
	    text = reader.ReadToEnd();
	}

	Regex regex = 
	    new Regex(@"(?<ip>(\d{1,3}\.){3}\d{1,3})\s+(?<name>(\S+))");

	MatchCollection matches = regex.Matches(text);
	foreach (Match match in matches) {
	    if (match.Length != 0) {
		Console.WriteLine("hostname {0} is mapped to ip address {1}",
				  match.Groups["name"], match.Groups["ip"]);
	    }
	}
    }
}
