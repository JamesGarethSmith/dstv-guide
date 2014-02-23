require 'spec_helper'

describe Channel do
  it "should require title" do
    build(:channel, title: "").should_not be_valid
  end

  it "should require number" do
    build(:channel, number: nil).should_not be_valid
  end

  it "number should be unique" do
    create(:channel, number: 203)
    build(:channel, number: 203).should_not be_valid
  end

  it "title should be unique" do
    create(:channel, title: "Supersport 3")
    build(:channel, title: "Supersport 3").should_not be_valid
  end

  it "should have matches" do
    r = Channel.reflect_on_association(:matches)
    r.macro.should == :has_many
  end

  it "should return it's title for 'to_s'" do
    match = build(:channel, title: "Title")
    match.to_s.should == "Title"
  end
end