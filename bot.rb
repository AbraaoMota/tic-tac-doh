class Bot

  def initialize(game)
    @game = game
    @state = game.state
    @current_player = game.current_player
  end

  def get_best_move
    return "B2" if @game.board_empty?
    move_scores = find_move_scores
    best_score = -20000
    best_move = move_scores.keys.first
    move_scores.each do |move, score|
      # binding.pry
      if score > best_score
        best_score = score
        best_move = move
      end
    end
    # binding.pry
    best_move
  end

  def find_move_scores(game = @game)
    moves = available_moves(game)
    move_scores = init_move_scores(moves)
    moves.each do |move|
      game_duplicate = deep_copy(game)
      game_duplicate.make_move(move)

      # binding.pry
      recursive_find_moves(game_duplicate, 1, move, move_scores)
      puts "JUST FOUND SCORES FOR THE MOVE #{move}"
      puts "MOVE SCORES ARE: #{move_scores}"
    end
    puts "FINAL MOVE SCORES ARE: #{move_scores}"
    move_scores
  end

  def recursive_find_moves(game, search_depth, original_move, move_scores)
    # puts game.print_state
    # puts move_scores

    if game.winner == @current_player
      move_scores[original_move] += score_strength(search_depth)
      return
    elsif game.winner == other_player
      move_scores[original_move] -= score_strength(search_depth)
      return
    end

    opponent_moves = available_moves(game)
    opponent_moves.each do |opp_mov|
      game_dup = deep_copy(game)
      game_dup.make_move(opp_mov)
      recursive_find_moves(game_dup, search_depth + 1, original_move, move_scores)
    end
  end

  def available_moves(game = @game)
    avail_moves = []
    cols = ['A', 'B', 'C']
    @state.each_with_index do |row, r_i|
      cols.each do |col|
        move = "#{col}#{r_i + 1}"
        avail_moves << move if game.empty?(move)
      end
    end
    avail_moves
  end

  private

  def other_player
    @current_player == 1 ? 2 : 1
  end

  def deep_copy(obj)
    Marshal::load(Marshal.dump(obj))
  end

  def score_strength(depth)
    20000 / (depth ** 2)
  end

  def init_move_scores(moves)
    moves_to_scores = {}
    moves.each do |move|
      moves_to_scores[move] = 0
    end
    moves_to_scores
  end
end
