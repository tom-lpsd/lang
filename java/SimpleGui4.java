import javax.swing.*;
import java.awt.*;
import java.awt.event.*;

public class SimpleGui4 {

    JFrame frame;
    int x,y;

    public static void main(String args[]) {
	SimpleGui4 gui = new SimpleGui4();
	gui.go();
    }

    public void go() {
	frame = new JFrame();
	frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);

	MyDrawPanel drawPanel = new MyDrawPanel();

	frame.getContentPane().add(BorderLayout.CENTER, drawPanel);
	frame.setSize(300,300);
	frame.setVisible(true);

	try {
	    for(int i=0;i<300;i++) {
		x++;
		y++;
		Thread.sleep(10);
		frame.repaint();
	    }
	    for(int i=0;i<300;i++) {
		x--;
		Thread.sleep(10);
		frame.repaint();
	    }
	    for(int i=0;i<300;i++) {
		y--;
		Thread.sleep(10);
		frame.repaint();
	    }
	}
	catch (Exception e) {
	    e.printStackTrace();
	}
	    
    }

    class MyDrawPanel extends JPanel {
	public void paintComponent(Graphics g) {
	    g.setColor(Color.yellow);
	    g.fillOval(x,y,10,10);
	}
    }

}