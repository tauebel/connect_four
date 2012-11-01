require_relative '../lib/game'

describe Game do
  let(:jake) { Player.new("Jake") }
  let(:karim) { Player.new("Karim") }
  let(:game) { Game.new(jake, karim) }

  context "next_game" do
    it "starts a fresh board" do
      Board.should_receive(:new).and_return(true)
      game
    end
  end

  context "player_turn" do
    it "assigns a player a turn" do
      game.turn.should eq "Jake"
    end
  end

  context "next_turn" do
    it "changes player to other player" do
      game.next_turn
      game.turn.should eq "Karim"
    end
  end

end