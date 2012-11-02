require_relative "../lib/database"

describe "Database" do


let (:db) {Database.new("test_db.db", "../../db/schema.sql")}
let(:player) {Player.new("Joe")}

  it "has the correct number of tables" do
    db.db.execute("SELECT count(*) FROM sqlite_master").flatten[0].should eq(4)
  end

  it "adds a player" do
    db.add_player(player)
  end

  it "gets a player's data" do
    db.get_player(player)[1].to_s.should eq("Joe")
  end

  it "returns a player's win-loss record" do
    db.get_player_win_loss(player).should eq([0,0,0])
  end

end