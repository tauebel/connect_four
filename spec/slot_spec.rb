require_relative '../lib/slot'

describe Slot do
  let(:slot) {Slot.new  }

  context "empty?" do
    it "returns true when slot is empty" do
      slot.should be_empty
    end

    it "returns false when filled" do
      slot.fill("red")
      slot.should_not be_empty
    end
  end

  context "color" do
    it "returns nil when initialized" do
      slot.color.should be nil
    end

    it "returns color when filled" do
      slot.fill("yellow")
      slot.color.should eq "yellow"
    end
  end

  context "fill" do
    it "fills slot with color" do
      slot.fill("red")
      slot.color.should eq "red"
    end

    it "raises an error if already filled" do
      slot.fill("red")
      slot.fill("yellow").should eq "already filled"
    end

    it "doesn't change slot if already filled" do
      slot.fill("red")
      slot.fill("yellow")
      slot.color.should eq "red"
    end
  end

end

