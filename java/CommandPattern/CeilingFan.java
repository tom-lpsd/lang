public class CeilingFan {
    String place;

    public CeilingFan(String place) {
	this.place = place;
    }

    public void go(int power) {
	System.out.println(place + ": ceiling fan goes on power " + power);
    }

    public void stop() {
	System.out.println(place + ": ceiling fan stop.");
    }
}

