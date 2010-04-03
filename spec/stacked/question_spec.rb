require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Stacked::Question do
  context "class methods" do
    subject { Stacked::Question }
    it "gets a list of all questions" do
      subject.all.all? { |q| q.is_a?(subject) }.should be_true
    end

    it "gets a list of questions with comments" do
      pending("Cannot currently get a list of questions with comments")
      subject.all(:comments => true)
    end

    it "active" do
      subject.active(:pagesize => 1).first.last_activity_date.should be_within(1.day)
    end

    it "newest" do
      subject.newest(:pagesize => 1).first.creation_date.should be_within(1.day)
    end

    it "featured" do
      (subject.featured(:pagesize => 1).first.bounty_closes_date > Time.now.to_i).should be_true
    end

    it "hot" do
      # It was 3555 as of 3rd April 2010.
      (subject.hot(:pagesize => 1).first.view_count > 3555).should be_true
    end

    it "month" do
      subject.month(:pagesize => 1).first.creation_date.should be_within(1.month)
    end

    it "week" do
      subject.week(:pagesize => 1).first.creation_date.should be_within(1.week)
    end

    it "votes" do
      subject.votes(:pagesize => 1).first.up_vote_count.should eql(1190)
    end
  end

  context "instance methods" do
    subject { Stacked::Question.find(1236996, :comments => true) }
    
    aliases(
            :created_at => :creation_date,
            :down_votes => :down_vote_count,
            :favorites  => :favorite_count,
            :favourites => :favorite_count,
            :id         => :question_id,
            :updated_at => :last_edit_date,
            :up_votes   => :up_vote_count,
            :user       => :owner,
            :views      => :view_count
            )
            

    it "is the right question" do
      subject.title.should eql("Calculating the distance between two times")
    end

    it "retreives comments" do
      subject.comments.should_not be_empty
      subject.comments.first.should be_is_a(Stacked::Comment)
    end

    it "retreives answers" do
      subject.answers.should_not be_empty
      subject.answers.first.should be_is_a(Stacked::Answer)
    end

    it "finds the user for a question" do
      subject.user.should be_is_a(Stacked::User)
    end
    
    it "finds the accepted answer" do
      subject.accepted_answer.should be_is_a(Stacked::Answer)
    end

  end

end