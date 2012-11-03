require_relative '../lib/slot'

describe Slot do
  let(:slot) {Slot.new  }

  context "empty?" do
    it "returns true when slot is empty" do
      slot.should be_empty
    end

    it "returns false when filled" do
      slot.fill("X")
      slot.should_not be_empty
    end
  end

  context "color" do
    it "returns nil when initialized" do
      slot.color.should be nil
    end

    it "returns color when filled" do
      slot.fill("O")
      slot.color.should eq "O"
    end
  end

  context "fill" do

    it "fills slot with color" do
      slot.fill("X")
      slot.color.should eq "X"
    end

    it "raises an error if already filled" do
      slot.fill("X")
      slot.fill("O").should eq "already filled"
    end

    it "doesn't change slot if already filled" do
      slot.fill("X")
      slot.fill("O")
      slot.color.should eq "X"
    end

    it "should change value from 0 to 1 " do
      expect{slot.fill("X")}.to change{slot.value}.from(0).to(1)
    end
  end

end

