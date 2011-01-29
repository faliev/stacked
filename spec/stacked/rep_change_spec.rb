require 'spec_helper'

describe Stacked::RepChange do
  before(:all) do
    fake "users/22656"
    fake "users/22656-reputation", :url_path => 'users/22656/reputation', :query => { :fromdate => 1270132345, :todate => 1270132348 }
    fake "answers/2272830" # referenced by subject.post
  end
  
  # Being very particular about what Reputation we mean...
  subject { Stacked::User.find(22656).rep_changes(:fromdate => 1270132345, :todate => 1270132348).first }

  it "should be able to find the related post" do
    subject.post.should be_is_a(Stacked::Answer)
  end

  it "should be able to work out the score of a reputation" do
    # Yeah right, like anyone would ever vote down a Jon Skeet answer and live.
    subject.stub!(:negative_rep => 15)
    subject.score.should eql(0)
  end
end