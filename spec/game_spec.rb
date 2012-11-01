require_relative '../lib/game'

describe Game do
  let(:jake) { Player.new("Jake") }
  let(:karim) { Player.new("Karim") }
  let(:game) { Game.new(jake, karim) }

  context "#next_game" do
    it "starts a fresh board" do
      Board.should_receive(:new).and_return(true)
      game
    end
  end

  context "#player_turn" do
    it "assigns a player a turn" do
      game.turn.should eq "Jake"
    end
  end

  context "#next_turn" do
    it "changes player to other player" do
      game.next_turn
      game.turn.should eq "Karim"
    end
  end

  context "#possible_moves" do
    it "returns available moves" do
      game.board.should_receive(:available_slots)
      game.possible_moves
    end
  end

  context "make_move" do
    it "calls fill_slot on board" do
      game.board.should_receive(:fill_slot).with("R",3,1)
      game.make_move(3,1)
    end

    it "returns an error if slot is not available" do
      game.make_move(3,2).should eq "This is not an available move"
    end

    it "advances the turn" do
      expect{game.make_move(3,1)}.to change{game.turn}.from("Jake").to("Karim")
    end
  end

end