require 'spec_helper'

describe Match do
  it "should require a title" do
    build(:match, title: "").should_not be_valid
  end

  it "should require a start time" do
    build(:match, starts_at: "").should_not be_valid
  end

  it "should require an end time" do
    build(:match, ends_at: "").should_not be_valid
  end

  it "should have a channel" do
    r = Match.reflect_on_association(:channel)
    r.macro.should == :belongs_to
  end

  it "should represent itself by it's title" do
    match = build(:match, title: "The title")
    match.to_s.should == "The title"
  end

  it "should mark current match as 'now_on?'" do
    match = build(:match, starts_at: Time.now - 1.hour, ends_at: Time.now + 1.hour)
    match.now_on?.should == true
  end

  it "should mark past match as not 'now_on?'" do
    match = build(:match, starts_at: Time.now - 2.hour, ends_at: Time.now - 1.hour)
    match.now_on?.should == false
  end

  it "should mark future match as not 'now_on?'" do
    match = build(:match, starts_at: Time.now + 1.hour, ends_at: Time.now + 2.hour)
    match.now_on?.should == false
  end
end