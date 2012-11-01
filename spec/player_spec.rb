require_relative '../lib/player'

describe  "Player" do
	let(:player) {Player.new("Joe", "test@test.com")}

  it "has a name of Joe" do
    player.name.should eq("Joe")
  end

  it "return an id from the database" do
    player.id.should eq(1)
  end

  it "should raise an error if the email is already taken" do
    expect{Player.new("Dave", "test@test.com")}.to raise_error
  end

  context "win_loss" do
    it "should retrieve its win-loss record from the database" do
      player.win_loss.should eq([0,0,0])
    end
  end

end

