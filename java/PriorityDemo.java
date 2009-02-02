class NormPriorityThread extends Thread {
    public void run() {
	for (int i = 0; i < 10000000; i++) {
	    double k = Math.sin(i);
	}
    }
}

class LowPriorityThread extends Thread {
    public void run() {
	setPriority(MIN_PRIORITY);
	try {
	    for (int i = 0; i < Integer.MAX_VALUE; i++)
		System.out.println("Low Priority thread: " + i);
	}
	catch (Exception e) {
	    e.printStackTrace();
	}
    }
}

class PriorityDemo {
    public static void main (String args[]) {

	LowPriorityThread lpt = new LowPriorityThread();
	lpt.start();
	
	try{
	    Thread.sleep(2000);
	}
	catch (Exception e) {
	    e.printStackTrace();
	}

	NormPriorityThread npt = new NormPriorityThread();
	npt.start();
    }
}