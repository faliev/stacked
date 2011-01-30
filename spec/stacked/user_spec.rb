require 'spec_helper'

describe Stacked::User do
  
  subject { Stacked::User }
  
  before(:all) do
    fake "users"
    fake "users/newest",  :url_path => 'users', :query => { :sort => 'creation' }
    fake "users/oldest",  :url_path => 'users', :query => { :sort => 'creation', :order => 'asc' }
    fake "users/name",    :url_path => 'users', :query => { :sort => 'name', :filter => 'ryan' }
    fake "users/filter",  :url_path => 'users', :query => { :filter => 'Ryan Bigg' }
  end
  
  context "class methods" do

    it "gathers the newest user" do
      subject.all(:sort => 'creation').first.creation_date.should be_within(1.day)
    end

    it "gathers the oldest user" do
      subject.all(:sort => 'creation', :order => 'asc').first.display_name.should eql("Community")
    end

    it "gathers the users by name" do
      subject.all(:sort => 'name', :filter => 'ryan').first.display_name.should eql("ytbryan")
    end

    it "gathers users by reputation" do
      subject.all.first.display_name.should eql("Jon Skeet")
    end

    it "gathers all the Ryan Bigg users" do
      subject.all(:filter => "Ryan Bigg").first.display_name.should eql("Ryan Bigg")
    end
  end

  context "instance methods" do
    before(:all) do
      fake "users/22656"
    end
    
    subject { Stacked::User.find(22656) }

    context "answers" do
      before(:all) do
        fake "users/22656-answers", :url_path => 'users/22656/answers'
        fake "users/22656-answers-by-activity", :url_path => 'users/22656/answers', :query => { :sort => 'activity' }
        fake "users/22656-answers-by-creation", :url_path => 'users/22656/answers', :query => { :sort => 'creation' }
        fake "users/22656-answers-by-votes", :url_path => 'users/22656/answers', :query => { :sort => 'votes' }
        fake "users/22656-answers-by-views", :url_path => 'users/22656/answers', :query => { :sort => 'views' }
      end
      
      it "finds the user's answers" do
        subject.answers.should_not be_empty
        subject.answers.first.should be_is_a(Stacked::Answer)
      end

      it "finds the user's most recent answers" do
        subject.answers(:sort => 'activity').should be_sorted_by(:last_activity_date, :desc)
      end
      
      it "finds the user's newest answers" do
        subject.answers(:sort => 'creation').should be_sorted_by(:creation_date, :desc)
      end
      
      it "finds the user's most popular answers" do
        subject.answers(:sort => 'votes').should be_sorted_by(:score, :desc)
      end
      
      it "finds the user's most viewed answers" do
        subject.answers(:sort => 'views').should be_sorted_by(:view_count, :desc)
      end
    end

    context "comments" do
      before(:all) do
        fake "users/148722"
        fake "users/148722-comments", :url_path => 'users/148722/comments'
        fake "users/148722-comments-by-creation", :url_path => 'users/148722/comments', :query => { :sort => 'creation' }
        fake "users/148722-comments-by-votes", :url_path => 'users/148722/comments', :query => { :sort => 'votes' }
      end
      
      subject { Stacked::User.find(148722) }
      
      it "finds some of the user's comments" do
        subject.comments.should_not be_empty
        subject.comments.first.should be_is_a(Stacked::Comment)
      end

      it "finds the user's recent comments" do
        subject.comments(:sort => 'creation').should be_sorted_by(:creation_date, :desc)
      end

      it "finds the user's most awesome comments" do
        subject.comments(:sort => 'votes').should be_sorted_by(:score, :desc)
      end
    end
    
    context "comments mentioning" do
      before(:all) do
        fake "users/22656-comments-mentioning-by-creation", :url_path => 'users/22656/comments/133566', :query => { :sort => 'creation', :fromdate => 1270107600, :todate => 1270107700 }
        fake "users/22656-comments-mentioning-by-votes",    :url_path => 'users/22656/comments/133566', :query => { :sort => 'votes', :fromdate => 1270107600, :todate => 1270107700 }
      end
      
      it "finds all comments directed at a user recently" do
        subject.comments_mentioning_user(133566, :sort => 'creation', :fromdate => 1270107600, :todate => 1270107700).first.should be_is_a(Stacked::Comment)
      end
      
      it "finds all comments directed at a user by score" do
        subject.comments_mentioning_user(133566, :sort => 'votes', :fromdate => 1270107600, :todate => 1270107700).first.should be_is_a(Stacked::Comment)
      end
    end

    context "favorites" do
      before(:all) do
        fake "users/22656-favorites", :url_path => 'users/22656/favorites'
        fake "users/22656-favorites-by-activity", :url_path => 'users/22656/favorites', :query => { :sort => 'activity' }
        fake "users/22656-favorites-by-views",    :url_path => 'users/22656/favorites', :query => { :sort => 'views' }
        fake "users/22656-favorites-by-creation", :url_path => 'users/22656/favorites', :query => { :sort => 'creation' }
        fake "users/22656-favorites-by-added",    :url_path => 'users/22656/favorites', :query => { :sort => 'added' }
      end
      
      it "finds the user's favorite questions" do
        subject.favorites.should_not be_empty
        subject.favorites.first.should be_is_a(Stacked::Question)
      end

      it "finds the most recent favorites" do
        subject.favorites(:sort => 'activity').should be_sorted_by(:last_activity_date, :desc)
      end

      it "finds the most viewed favorites" do
        subject.favorites(:sort => 'views').should be_sorted_by(:view_count, :desc)
      end

      it "finds the newest favorites" do
        subject.favorites(:sort => 'creation').should be_sorted_by(:creation_date, :desc)
      end

      it "finds the favorites in the order they were made favorite" do
        # How the devil do you test this?
        subject.favorites(:sort => 'added').first.should be_is_a(Stacked::Question)
      end

    end

    context "questions" do
      before(:all) do
        fake "users/22656-questions", :url_path => 'users/22656/questions'
        fake "users/22656-questions-by-activity", :url_path => 'users/22656/questions', :query => { :sort => 'activity' }
        fake "users/22656-questions-by-views",    :url_path => 'users/22656/questions', :query => { :sort => 'views' }
        fake "users/22656-questions-by-creation", :url_path => 'users/22656/questions', :query => { :sort => 'creation' }
        fake "users/22656-questions-by-votes",    :url_path => 'users/22656/questions', :query => { :sort => 'votes' }
      end

      it "finds the user's questions" do
        question = subject.questions.first
        question.should be_is_a(Stacked::Question)
        question.owner.user_id.should eql(subject.user_id)
      end

      it "finds the user's recent questions" do
        questions = subject.questions(:sort => 'activity')
        questions.should be_sorted_by(:last_activity_date, :desc)
      end

      it "finds the user's most viewed questions" do
        questions = subject.questions(:sort => 'views')
        questions.should be_sorted_by(:view_count, :desc)
      end

      it "finds the user's newest questions" do
        questions = subject.questions(:sort => 'creation')
        questions.should be_sorted_by(:creation_date, :desc)
      end

      it "finds the user's most popular questions" do
        questions = subject.questions(:sort => 'votes')
        questions.should be_sorted_by(:score, :desc)
      end
    end

    it "reputation changes" do
      fake "users/22656-reputation", :url_path => 'users/22656/reputation'
      
      change = subject.rep_changes.first
      change.should be_is_a(Stacked::RepChange)
    end

    it "mentioned / mentions" do
      fake "users/22656-mentioned", :url_path => 'users/22656/mentioned'
      
      subject.mentioned.first.should be_is_a(Stacked::Comment)
    end

    it "timeline" do
      fake "users/22656-timeline", :url_path => 'users/22656/timeline'
      
      subject.timeline.first.should be_is_a(Stacked::UserTimeline)
    end

    it "tags" do
      fake "users/22656-tags", :url_path => 'users/22656/tags'
      
      subject.tags.first.should be_is_a(Stacked::Tag)
    end

    it "badges" do
      fake "users/22656-badges", :url_path => 'users/22656/badges'
      
      subject.badges.first.name.should eql("Teacher")
    end

  end
end