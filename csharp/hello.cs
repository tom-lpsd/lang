public class HelloWorld {
  public static void Main(string [] args) {
    if(args.Length != 1){
      System.Console.Error.WriteLine("Please Enter your name.");
      System.Environment.Exit(-1);
    }
    string name = args[0];
    System.Console.WriteLine("Hello World {0}!", name);
  }
};
