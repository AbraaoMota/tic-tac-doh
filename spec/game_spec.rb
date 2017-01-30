require_relative "../game.rb"

RSpec.describe Game do

  before(:each) do
    @game = Game.new(2)
  end

  describe "#valid_move?" do

    let(:invalid_input) { "Bloop" }
    it "returns false for invalid input" do
      expect(@game.valid_move?(invalid_input)).to be false
    end

    let(:semi_empty_state) { [['x', 'o', 'o'],['o', 'o', 'x'],['x', '', '']] }
    let(:empty_move) { "C3" }
    it "returns true for moves within the grid on empty squares" do
      @game.instance_variable_set("@state", semi_empty_state)
      expect(@game.valid_move?(empty_move)).to be true
    end

    let(:semi_full_state) { [['', '', 'o'],['o', '', 'x'],['x', '', '']] }
    let(:non_empty_move) { "C1" }
    it "returns false for taken up grid moves" do
      @game.instance_variable_set("@state", semi_full_state)
      expect(@game.valid_move?(non_empty_move)).to be false
    end
  end

  describe "#winner" do

    let(:cross_win_state) { [['x', 'x', 'x'],['o', 'o', 'x'],['o', '', '']] }
    it "returns 1 if player 1 (crosses) has won" do
      @game.instance_variable_set("@state", cross_win_state)
      # Needed to emulate player 1 just having played
      @game.instance_variable_set("@current_player", 2)
      expect(@game.winner).to eq(1)
    end

    let(:nought_win_state) { [['o', 'x', 'x'],['o', 'o', 'x'],['x', 'x', 'o']] }
    it "returns 2 if player 2 (noughts) has won" do
      @game.instance_variable_set("@state", nought_win_state)
      expect(@game.winner).to eq(2)
    end

    let(:ongoing_state) { [['o', 'x', 'x'],['o', '', 'x'],['x', 'x', 'o']] }
    it "returns nil if noone has won yet" do
      @game.instance_variable_set("@state", ongoing_state)
      expect(@game.winner).to be nil
    end

    let(:tied_state) { [['o', 'x', 'x'],['x', 'o', 'o'],['o', 'o', 'x']] }
    it "returns nil if the game was a tie" do
      @game.instance_variable_set("@state", tied_state)
      expect(@game.winner).to be nil
    end
  end

  describe "#empty?" do

    let(:empty_space_state) { [['o', '', 'x'],['x', '', 'o'],['o', '', 'x']] }
    let(:empty_grid_move) { "B2" }
    it "returns true if a grid move is empty" do
      @game.instance_variable_set("@state", empty_space_state)
      expect(@game.empty?(empty_grid_move)).to be true
    end

    let(:semi_used_state) { [['o', '', 'x'],['x', '', 'o'],['o', '', 'x']] }
    let(:already_used_move) { "A1" }
    it "returns false if a grid move has been played already" do
      @game.instance_variable_set("@state", semi_used_state)
      expect(@game.empty?(already_used_move)).to be false
    end
  end

  describe "#make_move" do

    let(:before_move_state) { [['o', '', 'x'],['x', '', 'o'],['o', '', 'x']] }
    let(:move_chosen) { "B1" }
    let(:after_move_state) { [['o', 'x', 'x'],['x', '', 'o'],['o', '', 'x']] }
    it "changes the state of the game by applying a move to it" do
      @game.instance_variable_set("@state", before_move_state)
      @game.make_move(move_chosen)
      expect(@game.state).to eq(after_move_state)
    end

    let(:previous_player) { 1 }
    let(:new_player) { 2 }
    it "switches the current player" do
      @game.instance_variable_set("@current_player", previous_player)
      @game.make_move("A1")
      expect(@game.current_player).to eq(new_player)
    end
  end

  describe "#finished?" do

    let(:won_game_state) { [['x', 'x', 'x'],['x', '', 'o'],['o', '', 'x']] }
    it "returns true if the game has been won" do
      @game.instance_variable_set("@state", won_game_state)
      expect(@game.finished?).to be true
    end

    let(:tied_game_state) { [['x', 'o', 'x'],['x', 'o', 'o'],['o', 'x', 'x']] }
    it "returns true if the game has been tied" do
      @game.instance_variable_set("@state", tied_game_state)
      expect(@game.finished?).to be true
    end

    it "returns false if the board is empty" do
      expect(@game.finished?).to be false
    end

    let(:first_move_state) { [['x', '', ''],['', '', ''],['', '', '']] }
    it "returns false if the game is ongoing" do
      @game.instance_variable_set("@state", first_move_state)
      expect(@game.finished?).to be false
    end
  end

  describe "#tie?" do

    let(:tied_state) { [['x', 'x', 'o'],['o', 'o', 'x'],['x', 'o', 'o']] }
    it "returns true if the board is full and noone won" do
      @game.instance_variable_set("@state", tied_state)
      expect(@game.tie?).to be true
    end

    let(:first_move_state) { [['x', '', ''],['', '', ''],['', '', '']] }
    it "returns false if the board is not full" do
      @game.instance_variable_set("@state", first_move_state)
      expect(@game.tie?).to be false
    end

    let(:won_game_state) { [['x', 'x', 'x'],['o', 'o', 'x'],['x', 'o', 'o']] }
    it "returns false if the game has been won" do
      @game.instance_variable_set("@state", won_game_state)
      expect(@game.tie?).to be false
    end
  end

  describe "#board_empty?" do

    it "returns true if there have been no moves on the board" do
      expect(@game.board_empty?).to be true
    end

    let(:first_move_state) { [['x', '', ''],['', '', ''],['', '', '']] }
    it "returns false if there has been a move played" do
      @game.instance_variable_set("@state", first_move_state)
      expect(@game.board_empty?).to be false
    end
  end
end
