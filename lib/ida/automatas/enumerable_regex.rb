module Ida
  module Automatas
    class EnumerableRegex

      def initialize(raw_regex)
        @raw_regex = raw_regex
      end

      def each
        regex_string.each_char
      end

      private


      def regex_string
        @_regex_string ||= calculate_regex_string
      end

      def calculate_regex_string
        @raw_regex.to_s.split(":").last[0..-2]
      end

    end
  end
end
