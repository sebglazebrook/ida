require "yaml"
require_relative "./enumerable_regex_factory"

module Ida
  module Automatas
    class TransitionDataBuilder

      OUTPUT_PATH = File.expand_path(File.join("..", "..", "..", "..", "data", "transiton_data.yml"), __FILE__)

      attr_reader :regexes

      def initialize
        @regexes = Hash.new
      end

      def from_regex(regex, name)
        @regexes[name] = EnumerableRegexFactory.create(regex)
      end

      def build
        transition_data = build_transition_data
        File.open(OUTPUT_PATH, "w") do |file|
          file.puts(transition_data.to_yaml)
        end
      end

      def valid?
        # TODO 
        # this could check that all inputs lead to 
        # an accepeted state
      end

      private

      def build_transition_data
        {
          :"0" => { "i" => 1, name: :start_state },
          :"1" => { "f" => 2 },
          :"2" => { name: :keyword, accepted: true  }
        }
      end

    end
  end
end
