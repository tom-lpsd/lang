class DrumKit {
    boolean topHat = true;
    boolean snare = true;
    void playSnare() {
	System.out.println("bang bang ba-bang");
    }
    void playTopHat() {
	System.out.println("ding ding da-ding");
    }
}

class DrumKitTestDrive {
    public static void main(String args[]) {
	DrumKit d = new DrumKit();
	d.playSnare();
	d.playTopHat();
	d.snare = false;
	if(d.snare == true) {
	    d.playSnare();
	}
    }
}