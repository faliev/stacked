module Stacked
  module Parser
  # Convert an answers result into a collection of Stacked::Answer objects.
    def parse_answers(result)
      parse_type(result, "answer")
    end
    # Convert a badges result into a collection of Stacked::Badge objects.
    def parse_badges(result)
      parse_type(result, "badge")
    end

    # Convert a comments result into a collection of Stacked::Comment objects.
    def parse_comments(result)
      parse_type(result, "comment")
    end
   
    # Convert a post timeline result into a collection of Stacked::PostTimeline objects.
    def parse_post_timeline(result)
      parse_type(result, "post_timeline")
    end
   
    # Convert a questions result into a collection of Stacked::Question objects.
    def parse_questions(result)
      parse_type(result, "question")
    end
   
    # Convert a reputation result into a collection of Stacked::Reputation objects.
    def parse_rep_changes(result)
      parse_type(result, "rep_change")
    end
   
    # Convert a tags result into a collection of Stacked::Tag objects.
    def parse_tags(result)
      parse_type(result, "tag")
    end
   
    # Convert a user timeline result into a collection of Stacked::Usertimeline objects.
    def parse_user_timeline(result)
      parse_type(result, "user_timeline")
    end
   
    # Converts the specified result into objects of the +type+ class.
    def parse_type(result, type)
      parse(result[type.pluralize], "Stacked::#{type.classify}".constantize)
    end
  end
end