require_relative '../lib/slot'

describe Slot do
  let(:slot) {Slot.new  }

  context "empty?" do
    it "returns true when slot is empty" do
      slot.should be_empty
    end

    it "returns false when filled" do
      slot.fill("R")
      slot.should_not be_empty
    end
  end

  context "color" do
    it "returns nil when initialized" do
      slot.color.should be nil
    end

    it "returns color when filled" do
      slot.fill("Y")
      slot.color.should eq "Y"
    end
  end

  context "fill" do

    it "fills slot with color" do
      slot.fill("R")
      slot.color.should eq "R"
    end

    it "raises an error if already filled" do
      slot.fill("R")
      slot.fill("Y").should eq "already filled"
    end

    it "doesn't change slot if already filled" do
      slot.fill("R")
      slot.fill("Y")
      slot.color.should eq "R"
    end

    it "should change value from 0 to 1 " do
      expect{slot.fill("R")}.to change{slot.value}.from(0).to(1)
    end
  end

end

