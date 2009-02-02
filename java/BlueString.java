import java.applet.Applet;
import java.awt.Color;
import java.awt.Graphics;

/*
 *  <applet code="BlueString" width="200" height="200"></applet>
 *
 */

public class BlueString extends Applet {
    public void paint(Graphics g) {
	g.setColor(Color.blue);
	g.drawString("This is Blue String!!", 20, 100);
    }
}