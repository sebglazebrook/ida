module Ida
  module Tokens
    class Number

      def initialize(value)
        @value = value
      end

      def ==(other)
        return false unless other.respond_to?(:value_equals?)
        other.value_equals?(@value)  
      end

      def value_equals?(value)
        @value == value
      end

    end
  end
end
