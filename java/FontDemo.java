import java.applet.Applet;
import java.awt.*;

/*
 *  <applet code="FontDemo" width="200" height="200"></applet>
 *
 */

public class FontDemo extends Applet {
    public void paint(Graphics g) {
	int baseline = 100;
	g.setColor(Color.black);
	g.drawLine(0, baseline, 200, baseline);
	g.setFont(new Font("Serif", Font.BOLD, 36));
	g.setColor(Color.black);
	g.drawString("Wxyz", 5, baseline);
    }
}