module Stacked
  # Stacked::User class.
  class User < Base

    class << self
      # All moderators.
      def moderators(options={})
        records(path + "/moderators", options)
      end
    end

    # Answers by this user.
    def answers(options={})
      self.class.parse_answers(request(singular(user_id) + "/answers", options))
    end
    
    # Badges awarded to user.
    def badges(options={})
      self.class.parse_badges(request(singular(user_id) + "/badges", options))
    end
    
    # Comments by this user.
    def comments(options={})
      self.class.parse_comments(request(singular(user_id) + "/comments", options))
    end
    
    # Comments by this user, mentioning another user
    def comments_mentioning_user(other_user_id, options={})
      self.class.parse_comments(request(singular(user_id) + "/comments/#{other_user_id}", options))
    end

    # Favorites of this user.
    def favorites(options={})
      self.class.parse_questions(request(singular(user_id) + "/favorites", options))
    end
    
    # Comments that are directed at user(s).
    def mentioned(options={})
      self.class.parse_comments(request(singular(user_id) + "/mentioned", options))
    end

    # Questions by user(s).
    def questions(options={})
      self.class.parse_questions(request(singular(user_id) + "/questions", options))
    end

    # Reputation changes for user(s).
    def rep_changes(options={})
      self.class.parse_rep_changes(request(singular(user_id) + "/reputation", options))
    end
    
    # Tags participated in by user(s).
    def tags(options={})
      self.class.parse_tags(request(singular(user_id) + "/tags", options))
    end

    # Timeline of actions by user(s).
    def timeline(options={})
      self.class.parse_user_timeline(request(singular(user_id) + "/timeline", options))
    end

  end
end