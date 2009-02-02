import java.applet.Applet;
import java.awt.Graphics;

/*
 *  <applet code="AppletLifecycle" width="300" height="200"></applet>
 *
 */

public class AppletLifecycle extends Applet {
    String str = "";
    public void init() {
	str += "init; ";
    }
    public void start() {
	str += "start; ";
    }
    public void stop() {
	str += "stop; ";
    }
    public void destroy() {
	System.out.println("destroy");
    }
    public void paint(Graphics g) {
	g.drawString(str, 10, 25);
    }
}