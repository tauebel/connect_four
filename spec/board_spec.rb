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

  context "slot_by_location" do
    it "returns appropriate slot" do
      board.fill_slot("Y", 3,1)
      board.slot_by_location(3,1).value.should eq 5
    end
  end

  context "field_value" do
    it "returns sum of field slots" do
      board.fill_slot("Y", 5 , 1 )
      board.fill_slot("Y", 2 , 1 )
      board.fill_slot("Y", 3 , 1 )
      board.fill_slot("Y", 4 , 1 )
      board.field_value(FIELD_H_2).should eq 20
    end
  end

  context "connect_4?" do
    it "returns false if none of the fields are winning" do
      board.connect_4?(1,2).should eq false
    end

    it "returns true if one of the fields are winning" do
      board.fill_slot("Y", 5 , 1 )
      board.fill_slot("Y", 2 , 1 )
      board.fill_slot("Y", 3 , 1 )
      board.fill_slot("Y", 4 , 1 )

      board.connect_4?(5,1).should eq true
    end
  end

end