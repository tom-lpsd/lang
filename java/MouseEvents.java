import java.applet.*;
import java.awt.*;
import java.awt.event.*;

/*
  <applet code="MouseEvents" width="300" height="300">
  </applet>
*/

public class MouseEvents extends Applet
    implements MouseListener {
    
    public void init() {
	addMouseListener(this);
    }

    public void mouseClicked(MouseEvent me) {
	setBackground(Color.blue);
    }

    public void mouseEntered(MouseEvent me) {
	setBackground(Color.green);
    }
    
    public void mouseExited(MouseEvent me) {
	setBackground(Color.red);
    }

    public void mousePressed(MouseEvent me) {
	setBackground(Color.white);
	repaint();
    }

    public void mouseReleased(MouseEvent me) {
	setBackground(Color.yellow);
	repaint();
    }
}
