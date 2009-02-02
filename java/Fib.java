aspect FibMonitor {
    public static int bottom = 5;
    pointcut tracedMethods(int n): call(int Fib.fib(int)) && args(n) && if (n > bottom);
    before(int n): tracedMethods(n) {
	System.out.println("** fin " + n);
    }
}

public class Fib {
    public static int fib(int n) {
	if (n < 2) 
	    return n;
	else
	    return fib(n-1) + fib(n-2);
    }

    public static void main(String[] args) {
	System.out.println(fib(8));
    }
}
