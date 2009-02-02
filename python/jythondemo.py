#!/usr/local/bin/jython
from pawt import swing
import java

def exit(e): java.lang.System.exit(0)

frame = swing.JFrame('Swing Example', visible=1)
button = swing.JButton('This is a Swinging example!', actionPerformed=exit)
frame.contentPane.add(button)
frame.pack()
