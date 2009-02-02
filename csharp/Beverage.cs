using System;

public interface IBeverage {
    string Brand { get; }
    double Volume { get; }
    double PercentCaffeine { get; }
}

public class Beverage : IBeverage {

    private string brand;
    private double volume;
    private double percentCaffeine;

    public Beverage(string brand, double volume, 
		    double percentCaffeine) {
	this.brand = brand;
	this.volume = volume;
	this.percentCaffeine = percentCaffeine;
    }

    public string Brand {
	get {
	    return brand;
	}
    }

    public double Volume {
	get {
	    return volume;
	}
    }

    public double PercentCaffeine {
	get {
	    return percentCaffeine;
	}
    }

    public override string ToString() {
	return Volume + " oz " + Brand + " with " +
	    PercentCaffeine + "% caffeine";
    }

}

public class BeverageTester {
    public static void Main(string[] args) {
	Beverage [] beverages = new Beverage[2];

	Beverage jolt = new Beverage("Jolt", 12.0, 0.25);
	beverages[0] = jolt;

	Beverage coke = new Beverage("Coca-Cola", 12.0, 0.125);
	beverages[1] = coke;

	foreach (Beverage beverage in beverages) {
	    Console.WriteLine(beverage);
	}
    }
}
