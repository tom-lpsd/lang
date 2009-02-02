import java.text.*;
import java.util.*;

public class Formatting {
    public static void main (String args[]) {
	double b = 53.47698;
	Locale ja = Locale.JAPAN;
	NumberFormat formatter = NumberFormat.getCurrencyInstance(ja);
	String money = formatter.format(b);
	System.out.println(money);
    }
}