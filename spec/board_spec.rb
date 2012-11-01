require_relative '../lib/board'

describe Board do

  let(:board) { Board.new }

  context "#slot_empty?" do
    it "checks if specific slot is empty" do
      board.slot_empty?(4,2).should eq true
    end
  end

  context "#full?" do
    it "returns false when not full" do
      board.should_not be_full
    end
  end

  context "#available_slots" do
    it "returns list of available slots positions" do
      board.available_slots.should eq [[1,1],[2,1],[3,1],[4,1],[5,1],[6,1],[7,1]]
    end
  end


  context "#fill_slot" do
    it "fills the correct slot" do
      expect {board.fill_slot("Y", 2 , 1 )}.to change{board.slot_empty?(2,1)}.from(true).to(false)
    end

    it "returns slot not available if slot not available" do
      board.fill_slot("Y", 1,2).should eq "slot not available"
    end

    it "changes available slot" do
      board.should_receive(:update_slots).with(2,1)
      board.fill_slot("Y", 2 , 1 )
    end

    it "doesn't change slot if slot is unavailable" do
      board.fill_slot("Y", 1,2)
      board.slot_empty?(1,2).should eq true
    end
  end

  context "update_slots" do
    it "changes available slot when slot is filled" do
      board.fill_slot("Y", 2 , 1 )
      board.available_slots.should eq [[1,1],[2,2],[3,1],[4,1],[5,1],[6,1],[7,1]]
    end
  end

end