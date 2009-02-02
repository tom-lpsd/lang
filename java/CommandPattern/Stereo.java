public class Stereo {
    String place;

    public Stereo(String place) {
	this.place = place;
    }

    public void on() {
	System.out.println(place + ": Stereo is on.");
    }

    public void off() {
	System.out.println(place + ": Stereo is off.");
    }

    public void setCD() {
	System.out.println(place + ": Stereo's mode is set to CD.");
    }

    public void setVolume(int volume) {
	System.out.println(place + ": Stereo's volume is set to " + volume + ".");
    }
}

