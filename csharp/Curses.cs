using System;
using System.Runtime.InteropServices;

public class Curses {
    const string Library = "libncurses.so.5";

    [DllImport(Library)]
    private extern static IntPtr initscr();

    [DllImport(Library)]
    private extern static int endwin();
    
    [DllImport(Library)]
    private extern static int mvwprintw(
	IntPtr window, int y, int x, string message);

    [DllImport(Library)]
    private extern static int refresh(IntPtr window);

    [DllImport(Library)]
    private extern static int wgetch(IntPtr window);

    private IntPtr window;

    public Curses() {
	window = initscr();
    }

    ~Curses() {
	int result = endwin();
    }
    
    public int Print(int x, int y, string message) {
	return mvwprintw(window, y, x, message);
    }

    public int Refresh() {
	return refresh(window);
    }

    public char GetChar() {
	return (char)wgetch(window);
    }
}

public class HelloCurses {
    public static void Main(string[] args) {
	Curses Curses = new Curses();
	Curses.Print(10, 10, "Hello, curses!");
	Curses.Refresh();
	char c = Curses.GetChar();
	Curses = null;
    }
}
