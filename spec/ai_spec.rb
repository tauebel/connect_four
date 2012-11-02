require_relative '../lib/ai'

describe  AI do
  let(:jake) { Player.new("Jake", "keemo") }
  let(:karim) { Player.new("Karim", "bobo") }
  let(:game) { Game.new(jake, karim) }
  let(:ai) {AI.new(game, game.board)}

  context "make_move" do
    it "call make move on game" do
      ai.column = 3
      ai.row = 2
      game.should_receive(:make_move).with(3,2)
      ai.make_move
    end
  end

end