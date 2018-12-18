# Reaction-Timer

## Overview
### Purpose
This circuit is meant to measure the reaction time of a user between 0 to 1000 milliseconds. The circuit uses three push buttons (Start, Stop and Clear). 

### State Transitions
When the circuit is loaded initialy it is set to a Starting state. When the user presses the Clear button it is set into an Init state and "HI" is displayed on the seven segment display. From here the user presses the Start button which sets the circuit into a Countdown state. In this state the circuit counts from 0 to a random number between 2000 and 15000 milliseconds. If the user presses the Stop button in this state, their reaction time is set to 9999 milliseconds and they are sent into the Early state. Once this countdown is reached, the circuit is set into the Test state which counts up from 0 to 1000 milliseconds. If the user presses the Stop button at any point durring this state, their reaction time is set to the value of this counter, and they are sent into the Good state. If they do not press the Stop button before the counter reaches 1000, their reaction time is set to 1000 milliseconds and they are sent into the Late state. When in any of these three states (Early, Good or Late) if the Clear button is pressed they are sent back into the Init state where they can repeat the test.

## State Diagram


## Program Structure
The ReactionTimer module is the top level module for the circuit design.
