class Game

  def initialize(mode, first)
    @mode = mode
    @first = first
    @state = [['', 'x', ''],['o', '', ''],['', 'o', 'x']]
  end

  def finished?
    !board_empty? && (vertical_win? || horizontal_win? || diagonal_win? || tie?)
  end

  def vertical_win?
    @state.transpose.each do |column|
      return true if all_the_same?(column)
    end
    false
  end

  def horizontal_win?
    @state.each do |row|
      return true if all_the_same?(row)
    end
    false
  end

  def diagonal_win?
    grid_size = @state.length
    diag1 = []
    diag2 = []
    for i in 0..grid_size-1
      diag1 << @state[i][i]
      diag2 << @state[grid_size-1-i][grid_size-1-i]
    end
    all_the_same?(diag1) || all_the_same?(diag2)
  end

  def tie?
    board_full? && !vertical_win? && horizontal_win? && !diagonal_win?
  end

  def board_full?
    @state.each do |row|
      return false if row.include?("")
    end
    true
  end

  def board_empty?
    @state.each do |row|
      return false unless row.all? { |elem| elem == '' }
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

  private

  def all_the_same?(array)
    array.uniq.length == 1
  end
end
