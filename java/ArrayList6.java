import java.util.*;

public class ArrayList6 {
    public static void printAL (ArrayList al) {
	for (int z=0;z<al.size();z++) {
	    System.out.print(z + "=" + al.get(z));
	    System.out.print(", ");
	}
	System.out.println(" ");
    }
    public static void main (String args[]) {
	ArrayList a = new ArrayList();
	a.add(0, "zero");
	a.add(1, "one");
	a.add(2, "two");
	a.add(3, "three");
	printAL(a);
	a.remove(2);
	if(a.contains("two")) {
	    a.add("2.2");
	}
	if(a.contains("three")) {
	    a.add("four");
	}
	printAL(a);
	if(a.indexOf("four") != 4) {
	    a.add(4, "4.2");
	}
	printAL(a);
	printAL(a);
    }
}