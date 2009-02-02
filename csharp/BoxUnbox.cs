using System;
using System.Collections;

public class BoxUnbox {
    public static void Main(string [] args) {
	ArrayList h = new ArrayList();
	int i = 10;
	h.Add(i);
	int j = (int)h[0];
	Console.WriteLine(j);

	int k = 1;
	object o = k;
	o = 10;
	int l = (int)o;
	Console.WriteLine(l);
	Console.WriteLine(k);
    }
}
