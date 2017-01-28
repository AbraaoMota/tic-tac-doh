class Game

  def initialize(mode, first)
    @current_player = 1
    @mode = mode
    @first = first
    @state = [['', 'x', ''],['o', '', ''],['', 'o', 'x']]
  end

  def valid_move?(move)
    return false if move.length != 2
    letter = move[0].downcase
    row = move[1].to_i
    letters_to_cols.keys.include?(letter.to_sym) && row > 0 && row < 4 && empty?(move)
  end

  def winner
    if finished? && !tie?
      @current_player == 1 ? 2 : 1
    end
  end

  def move_to_num(move)
    col = letters_to_cols[move[0].downcase.to_sym]
    row = move[1].to_i - 1
    return row, col
  end

  def empty?(move)
    row, col = move_to_num(move)
    @state[row][col] == ''
  end

  def make_move(move)
    row, col = move_to_num(move)
    piece = ''
    if @current_player == 1
      piece = 'x'
      @current_player = 2
    else
      piece = 'o'
      @current_player = 1
    end
    @state[row][col] = piece
  end

  def finished?
    !board_empty? && (vertical_win? || horizontal_win? || diagonal_win? || tie?)
  end

  def vertical_win?
    @state.transpose.each do |column|
      return true if all_the_same?(column) && !all_blank?(column)
    end
    false
  end

  def horizontal_win?
    @state.each do |row|
      return true if all_the_same?(row) && !all_blank?(column)
    end
    false
  end

  def diagonal_win?
    grid_size = @state.length
    diag1 = []
    diag2 = []
    for i in 0..grid_size-1
      diag1 << @state[i][i]
      diag2 << @state[i][grid_size-1-i]
    end
    (all_the_same?(diag1) && !all_blank?(diag1)) || (all_the_same?(diag2) && !all_blank?(diag2))
  end

  def tie?
    board_full? && !vertical_win? && !horizontal_win? && !diagonal_win?
  end

  def board_full?
    @state.each do |row|
      return false if row.include?('')
    end
    true
  end

  def board_empty?
    @state.each do |row|
      return false unless all_blank?(row)
    end
    true
  end

  def print_state
    output = "      A       B       C\n\n"
    @state.each_with_index do |row, r_i|
      row.each_with_index do |elem, c_i|
        if c_i == 0
          output << "#{r_i + 1}| "
        end
        output << "   #{elem}"
        if c_i == row.length - 1
          output << "\n |"
        else
          elem.empty? ? output << "    |" : output << "   |"
        end
      end
      output << "  ---------------------\n" unless r_i == @state.length - 1
    end
    puts output << "\n\n"
  end

  def current_player
    @current_player
  end

  private

  def all_blank?(set)
    set.all? { |elem| elem == '' }
  end

  def letters_to_cols
    { 'a': 0, 'b': 1, 'c': 2 }
  end

  def all_the_same?(array)
    array.uniq.length == 1
  end
end
