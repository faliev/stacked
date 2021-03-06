module Stacked
  # Stacked::Answer class.
  class Answer < Base
    
    class << self
      def all(*args)
        raise Stacked::NotImplemented
      end
    end
    
    # Comments for the answer.
    def comments(options={})
      parse_comments(request(singular(answer_id) + "/comments", options))
    end
    
    # Helper method for creating Stacked::User object when initializing new Stacked::Answer objects.
    def owner=(attributes)
      @owner = User.new(attributes)
    end
   
    # A Stacked::Question object representing the question the answer is in response to.
    def question
      @question ||= Question.find(question_id)
    end
  end
end