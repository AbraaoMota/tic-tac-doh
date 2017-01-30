class Bot

  def initialize(game)
    @game = game
    @state = game.state
    @current_player = game.current_player
  end

  def get_best_move
    move_scores = find_move_scores
    binding.pry
    best_score = -20000
    best_move = move_scores.keys.first
    move_scores.each do |move, score|
      if score > best_score
        best_score = score
        best_move = move
      end
    end
    best_move
  end

  def find_move_scores(game = @game, search_depth = 1)
    moves = available_moves(game)
    move_scores = init_move_scores(moves)
    moves.each do |move|
      game_duplicate = game.dup
      game_duplicate.make_move(move)
      if game_duplicate.winner == @current_player
        move_scores[move] += score_strength(search_depth)
      elsif game_duplicate.winner.nil?
        find_move_scores(game_duplicate, search_depth + 1)
      else
        move_scores[move] -= score_strength(search_depth)
      end
    end
    move_scores
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

  def score_strength(depth)
    20000 / (2 ** depth)
  end

  def init_move_scores(moves)
    moves_to_scores = {}
    moves.each do |move|
      moves_to_scores[move] = 0
    end
    moves_to_scores
  end
end
