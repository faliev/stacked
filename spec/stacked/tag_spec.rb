require 'spec_helper'

describe Stacked::Tag do
  subject { Stacked::Tag }
  
  before :all do
    fake "tags"
    fake "tags/popular", :url_path => 'tags', :query => { :sort => 'popular' }
    fake "tags/name", :url_path => 'tags', :query => { :sort => 'name', :order => 'asc' }
    fake "tags/activity", :url_path => 'tags', :query => { :sort => 'activity' }
  end
  
  it "finds all the tags" do
    subject.all.first.name.should eql("c#")
  end

  it "finds the popular tags" do
    subject.all(:sort => 'popular').should be_sorted_by(:count, :desc)
  end

  it "finds the tags ordered by name" do
    subject.all(:sort => 'name', :order => 'asc').should be_sorted_by(:name, :asc)
  end

  it "finds the tags used recently" do
    subject.all(:sort => 'activity').size.should eql(70)
  end
end