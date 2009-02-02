class Foo {
    Foo() {
	foo();
    }
    private void foo() {
	System.out.println("foo");
    }
}

class Bar extends Foo {
    Bar() {
    }
    void foo() {
	System.out.println("bar");
    }
}

class constructor_trap {
    public static void main(String[] args) {
	Bar bar = new Bar();
    }
}

