require_relative "../bot.rb"
require_relative "../game.rb"

require 'pry'

RSpec.describe Bot do
  describe "#get_best_move" do

    before(:each) do
      @game = Game.new(2)
    end

    let(:tough_state) { [['x', 'o', 'o'],['o', 'o', 'x'],['x', '', '']] }
    let(:tying_move) { "B3" }

    it "selects a move that prevents the opponent from winning" do
      @game.instance_variable_set("@state", tough_state)
      expect(Bot.new(@game).get_best_move).to eq tying_move
    end

    let(:winning_state) { [['x', 'o', 'o'],['x', 'o', 'x'],['', '', '']] }
    let(:winning_move) { "A3" }

    it "selects a move that immediately wins" do
      @game.instance_variable_set("@state", winning_state)
      expect(Bot.new(@game).get_best_move).to eq winning_move
    end
  end
end
