module RSpec
  module Matchers
    class SortedBy #:nodoc:
      def initialize(field=nil, direction=:asc)
        @field = field
        @direction = direction
        @pretty_direction = direction == :desc ? "descending" : "ascending"
      end

      def matches?(receiver)
        left = receiver[0].send(@field)
        right = receiver[1].send(@field)
        if @direction.to_sym == :desc
          left > right
        elsif @direction.to_sym == :asc
          left < right
        else
          raise "direction must be either :desc or :asc or their String counterparts"
        end
      end

      def failure_message
        "Expected result set to be sorted by #{@field} in #{@pretty_direction} order, but was not."
      end

    end

    def be_sorted_by(field=nil, direction=:asc)
      SortedBy.new(field, direction)
    end
  end
end
