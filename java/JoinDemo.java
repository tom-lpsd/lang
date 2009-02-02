class ThreadM extends Thread {
    public void run() {
	try {
	    for (int i = 0; i<10; i++) {
		Thread.sleep(100);
		System.out.println("ThreadM");
	    }
	}
	catch (InterruptedException ex) {
	    ex.printStackTrace();
	}
    }
}

class ThreadN extends Thread {
    public void run() {
	try {
	    for (int i = 0; i < 20; i++) {
		Thread.sleep(200);
		System.out.println("ThreadN");
	    }
	}
	catch (InterruptedException ex) {
	    ex.printStackTrace();
	}
    }
}

class JoinDemo1 {
    public static void main (String args[]) {
	ThreadM tm = new ThreadM();
	tm.start();
	ThreadN tn = new ThreadN();
	tn.start();
	try {
	    tm.join();
	    tn.join();
	    System.out.println("Both threads have finished");
	}
	catch (Exception e) {
	    e.printStackTrace();
	}
    }
}