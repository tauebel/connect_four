require_relative '../player'

describe  "Player" do
	let(:player) {Player.new("Joe")}
  # let(:make_move){[4,2]}

  it "has a class of player" do
    player.should be_an_instance_of Player
  end

  it "has a name of Joe" do
    player.name.should eq("Joe")
  end

  it "is allowed to make a move" 

  it "returns stats for a player from database" do
    player.stats.should eq ("Wins: 0, Loss: 0, Draw: 0")
  end
end

#
    # document.should_receive(:print).times(1).and_return(false)
