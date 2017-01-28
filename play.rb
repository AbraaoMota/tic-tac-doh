#!usr/bin/ruby

require 'pry'
require_relative "game"

puts "Welcome to tic-tac-doh"
puts "What mode would you like to play?"
puts "(1) Human vs Human"
puts "(2) Human vs Computer"
puts "(3) Computer vs Computer"
puts "\nSelect a number:"
mode = gets.chomp.to_i

if mode > 3 || mode < 0
  puts "Invalid mode. Quitting..."
  exit
end

first = false
if mode < 3
  puts "Would you like to play first? (Y/N)"
  first = gets.chomp.to_s
  if first != 'y' && first != 'Y' && first != 'n' && first != 'N'
    puts "Invalid input. Quitting..."
    exit
  end
  if first == 'y' || first == 'Y'
    first = true
  end
end

game = Game.new(mode, first)


current_player = 1

while !game.finished?

  if (first && current_player == 1) || (!first && current_player == 2)
    game.print_state
    puts "Please make a move. Use the grid to guide you, valid moves are 'LetterNumber' (e.g. A1)"
    move = gets.chomp.to_s
    if game.valid_move?(move)
      game.make_move(move)
    else
      while !game.valid_move?(move)
        puts "Invalid move, please try again."
        move = gets.chomp.to_s
      end
      game.make_move(move)
    end
  end

    sleep(2)
end

game.print_state
# Output outcome
puts "****************\n\n  "
if game.tie?
  puts "The game ended in a tie"
  exit
end
winner = game.winner
if mode == 1
  puts "Player #{winner} won"
elsif mode == 2
  if ((winner == 1 && first) || (winner == 2 && !first))
    puts "Congratulations, you somehow broke the game!"
  elsif winner == '1'
    puts "Sorry you lost... What did you expect?"
  end
else
  puts "Computer #{winner} won"
end
exit
