import java.lang.Thread;

class MyThread extends Thread {
    private String _msg;

    public static void main(String[] args) {
	new MyThread("Hello").start();
	new MyThread("World.").start();
    }

    public MyThread(String msg) {
	_msg = msg;
    }

    public void run() {
	for (int i=0;i<10000;++i) {
	    System.out.println(_msg);
	}
    }
}
