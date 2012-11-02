require_relative "../lib/database"
require_relative "../lib/player"
require_relative '../lib/game'
describe "Database" do

let (:db)     {Database.new("rspec_test_db.db", "../db/schema.sql")}
let(:player)  {Player.new("Joe", "joe@gmail.com")}
let(:player2) {Player.new("ted", "ted@gmail.com")}
let(:new_game){Game.new(player, player2)}

  it "has the correct tables" do
    [:players, :games, :game_moves].each do |table_name|
      db.db.execute("select name from sqlite_master where type=='table'").flatten.include?(table_name.to_s).should be_true
    end
  end

  it "adds a player" do
    db.db.execute("select name from players where email = '#{player.email}'")
  end

  it "gets a player's data" do
    player1 = Database.retrieve_player(player)
    player1[1].to_s.should eq "Joe"
  end

  it "returns a player's win" do
    player1 = Database.retrieve_player(player)
    player1[2].should eq(0)
  end

  it "returns a player's loss" do
    player1 = Database.retrieve_player(player)
    player1[3].should eq(0)
  end

  it "returns a player's draw" do
    player1 = Database.retrieve_player(player)
    player1[4].should eq(0)
  end

  it "can create a new game" do
    new_game.should be_an_instance_of Game
  end

end