# Reaction-Timer

## Overview
### Purpose
This circuit is meant to measure the reaction time of a user between 0 to 1000 milliseconds. The circuit uses three push buttons (Start, Stop and Clear). 

### State Transitions
When the circuit is loaded initialy it is set to a Starting state. When the user presses the Clear button it is set into an Init state and "HI" is displayed on the seven segment display. From here the user presses the Start button which sets the circuit into a Countdown state. In this state the circuit counts from 0 to a random number between 2000 and 15000 milliseconds. If the user presses the Stop button in this state, their reaction time is set to 9999 milliseconds and they are sent into the Early state. Once this countdown is reached, the circuit is set into the Test state which counts up from 0 to 1000 milliseconds. If the user presses the Stop button at any point durring this state, their reaction time is set to the value of this counter, and they are sent into the Good state. If they do not press the Stop button before the counter reaches 1000, their reaction time is set to 1000 milliseconds and they are sent into the Late state. When in any of these three states (Early, Good or Late) if the Clear button is pressed they are sent back into the Init state where they can repeat the test.

## State Diagram
![reaction timer state diagram](https://user-images.githubusercontent.com/36581610/50247110-04692e80-03a5-11e9-8d15-a08a566b4259.png)


## Program Structure
### ReactionTimeDriver 
This module is the top level module for the circuit design. It contains the Button Inputs as well as the Led and HEX display outputs. These inputs and outputs are assigned into the ReactionTimer module. It also handles the conversion of the 14 bit binary reaction time into 4 BCD digits that are then converted to HEX display as well as what is displayed on the HEX display depending on the current state. 

### ReactionTime 
This module handles the slowing of the clock, the generation of the random countdown number, as well as the counters for the Countdown and Test states. This module also handles the state transition logic.

### Random
This module is used to calculate a random number between 2000 and 15000. This is done by using a linear shift register.

### Counting
This module is responsible for counting from 0 to a set limit if enabled. If not enabled the count simply remains at 0. When the count is completed an output tick is produced.

### SlowClock
Slows the clock to 1Mhz which is equivalent to 1ms.

### BinaryToBCD
Converts the binary reaction time to 4 BCD digits.

### BCDToSevenSeg
Converts a 4 bit BCD digit to a 7 bit HEX output.
