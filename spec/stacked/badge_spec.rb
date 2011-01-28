require 'spec_helper'

describe Stacked::Badge do
  subject { Stacked::Badge }
  
  before :all do
    fake "badges"
    fake "badges/name"
    fake "badges/tags"
  end
  
  it "finds all badges" do
    badge = subject.all.first
    badge.should be_is_a(Stacked::Badge)
  end

  it "finds all badges ordered by name" do
    subject.name.first.should be_is_a(Stacked::Badge)
  end

  it "finds all badges based on tags" do
    subject.tags.first.name.should eql(".htaccess")
  end

end