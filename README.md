# tic-tac-doh!

A game of tic-tac-toe where the only time you win is against other humans.

## About

This is a simple command line tic-tac-toe game where you can play against another human, against a bot (though you will not beat it), or you can watch 2 bots duke it out in infinite ties.

Tic-tac-doh was written in ruby.

## Installing

To install, make sure you have ruby installed. It was written using ruby 2.3.3p222  . 

## Usage

To play the game, simply run

```
ruby play.rb
```

and follow the on-screen instructions. Have fun!

## Testing

TODO

## Bot algorithm

The algorithm used by the bots to find their optimal move at any given point looks ahead at every permutation of the game. 

The importance of any given permutation is related to the exponent of how deep the game has to look to get to that permutation. 

This means that the game values much more permutations of the game that are 1 or 2 moves away than those that are 5-6 moves away from the current state. 

The algorithm then sums up the value of these states, awarding positive points for those that end up with the bot player winning, and negative points if they lose. 

The moves are then associated with the scores of the states they generate, and the robot picks a move at random from the list of best moves it can play at that moment. This algorithm should guarantee that the worst outcome for any bot playing is a tie, and any match between two robots (in mode 3 within the game) should end in a tie.

Additionally, the bots sleep for a short period after deciding their move, so that a player can keep up with their moves without having to scroll up. 
