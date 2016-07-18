require_relative "./tokens/number"
require_relative "./automata"

module Ida
  class LexicalAnalyzer

    def initialize
      @automata = Automata.new
    end

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

  end
end
