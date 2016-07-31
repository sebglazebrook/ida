require_relative "./tokens/number"
require_relative "./automata"
require_relative "./automatas/transition_data_builder"
require "yaml"

module Ida
  class LexicalAnalyzer

    def initialize
      @automata = Automata.new(transition_data)
    end

    # TODO this needs to handle multiple non whitespace tokens and
    # break the iterating
    def analyze(raw_source_code)
      token = nil
      raw_source_code.each_char.with_index do |char, index|
        end_of_input = raw_source_code.size - index == 1
        if !@automata.transition!(char) || end_of_input
          token = @automata.create_token_unless_whitespace
          @automata.reset! unless token
        end
      end
      token
    end

    private

    def transition_data
      YAML.load_file(Ida::Automatas::TransitionDataBuilder::OUTPUT_PATH)
    end

  end
end
