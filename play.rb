#!usr/bin/ruby

require 'pry'
require_relative "game"
require_relative "bot"

puts "Welcome to tic-tac-doh"
puts "What mode would you like to play?"
puts "(1) Human vs Human"
puts "(2) Human vs Computer"
puts "(3) Computer vs Computer"
puts "\nSelect a number:"
mode = gets.chomp.to_i

if mode > 3 || mode <= 0
  puts "Invalid mode. Quitting..."
  exit
end

if mode == 2
  puts "Would you like to play first? (Y/N)"
  first = gets.chomp.to_s
  if first != 'y' && first != 'Y' && first != 'n' && first != 'N'
    puts "Invalid input. Quitting..."
    exit
  end
  if first == 'y' || first == 'Y'
    first = true
  else
    first = false
  end
end

game = Game.new(mode)

while !game.finished?
  current_player = game.current_player
  game.print_state

  # Player move (either only mode 1 or mode 2 their move)
  if mode == 1 || (!first.nil? && ((first && current_player == 1) || (!first && current_player == 2)))
    puts "Player #{current_player}, make a move. Valid moves are 'LetterNumber' (e.g. A1)"
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

  # Computer move (mode 2 robot move or just mode 3)
  if mode == 3 || (!first.nil? && ((first && current_player == 2) || (!first && current_player == 1)))
    puts "The computer (player #{current_player}) is deciding a move...\n\n"
    bot = Bot.new(game.dup)
    move = bot.get_best_move
    # Make `thinking` time long enough when just 2 bots are playing
    mode == 3 ? sleep(1.5) : sleep(1)
    game.make_move(move)
  end
end

game.print_state
# Output outcome
puts "  ****************\n"
winner = game.winner
winner == 1 ? piece = "crosses" : piece = "noughts"
if winner.nil? && game.tie?
  puts "  The game ended in a tie...\n"
elsif mode == 1
  puts "  Player #{winner} (#{piece}) won! "
elsif mode == 2
  if ((winner == 1 && first) || (winner == 2 && !first))
    puts "  Congratulations, you somehow broke the game!"
  else
    puts "  Sorry you lost... What did you expect?"
  end
elsif mode == 3
  puts "Computer #{winner} won!"
end
puts "  ****************\n\n  Thanks for playing! \n\n"
exit
