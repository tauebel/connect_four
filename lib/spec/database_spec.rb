require_relative "../database"

describe "Database" do
before(:all) do
    Database.new("test_db.db", "../../db/schema.sql")
end 

let (:db) {SQLite3::Database.open "test_db.db"}

  it "has the correct number of tables" do
    db.execute("SELECT count(*) FROM sqlite_master").flatten[0].should eq(4)
  end



end