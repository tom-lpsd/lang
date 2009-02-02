class Class1 {
    int i = 1000;

    void f() {
	int i = 100;
	System.out.println(i);
	g();
    }

    void g() {
	System.out.println(i);
    }
}

class VariableHidingDemo1 {
    public static void main(String args[]) {
	Class1 class1 = new Class1();
	class1.f();
    }
}
