#Mastermind

A console application version of the [Mastermind boardgame](https://en.wikipedia.org/wiki/Mastermind_(board_game)). Written in Ruby.

![title](http://i.imgur.com/yM7bawe.png)
![board](http://i.imgur.com/7iT9RxE.png)

----
## How to play
see [Wikipedia](https://en.wikipedia.org/wiki/Mastermind_(board_game)#Gameplay_and_rules)

1. Assign yourself a role. Whether that be code maker or code breaker.
2. A sequence of colored pegs are chosen by the code maker. The colors are; red, green, blue, yellow, pink, and orange. Colors are selected by typing the first letter of the color that you wish to select. Colors can be repeated, however colors cannot be left blank.
3. The code breaker has 12 attempts to guess the code. The code breaker types in the first letter of the 4 colors which they wish to play. eg: 'rgby' -> red, green, blue, yellow
4. The code breaker is presented with data pegs to help them out. A black peg means they have guessed a correct color in a CORRECT position. A white peg means they have guessed a correct color in a WRONG position.
5. If the code breaker gets presented with all black pegs, the game is over and the code breaker has won. If all 12 guesses are used up, the game is over and the code maker has won.

----
##How to run the program
1. Make sure you have [Ruby](https://www.ruby-lang.org/en/documentation/installation/) on your computer.
2. In the terminal type, "ruby (path-to-directory)/application.rb

----
##Notes
This program was written by Rhett Newton (rnewton5) as part of [The Odin Project's Curriculum](http://www.theodinproject.com/home).