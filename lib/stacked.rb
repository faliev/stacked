begin
  require 'rubygems'
rescue LoadError
  require 'bundler'
  Bundler.setup!
end

require 'active_support/all'

# The Stacked module.
module Stacked
  # TODO: Use this coupled with autoload_under when AS 3.0 becomes "stable":
  # extend ActiveSupport::Autoload
  # Will not then need to implement it ourselves.
  # 
  # Implement some AS 3.0 code for automatically determining autoload path.
  # Allows us to do:
  #
  # autoload :Base
  #
  # Instead of:
  #
  # autoload :Base, 'stacked/base'
  extend ActiveSupport::Autoload
  
  autoload :Client
  autoload :Answer
  autoload :Base
  autoload :Badge
  autoload :Comment
  autoload :PostTimeline
  autoload :Parser
  autoload :Question
  autoload :RepChange
  autoload :Tag
  autoload :User
  autoload :UserTimeline

  # NotImplemented::StandardError class.
  class NotImplemented < StandardError
    # Default message for trying to call all/find on unsupported resources.
    def message
      "The requested action is not available in the API."
    end
  end

end

