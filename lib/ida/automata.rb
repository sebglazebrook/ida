module Ida
  class Automata
    class UnacceptedStateError < StandardError; end
    class InvalidTokenError < StandardError; end

    attr_reader :current_state

    def initialize(transition_data = {})
      @transition_data = transition_data
      @current_state = 0
      @current_string = ""
    end

    def transition!(character)
      if @transition_data[@current_state.to_s.to_sym].keys.include?(character)
        @current_string += character
        @current_state = @transition_data[@current_state.to_s.to_sym][character]
        self
      else
        false
      end
    end

    def reset!
      @current_state = 0
      @current_string = ""
      self
    end

    def create_token_unless_whitespace
      raise UnacceptedStateError unless @transition_data[@current_state.to_s.to_sym][:accepted]
      unless @transition_data[@current_state.to_s.to_sym][:name] == :whitespace
        token = TokenFactory.create(@transition_data[@current_state.to_s.to_sym][:name], @current_string)
        token ? token : raise(InvalidTokenError)
      end
    end

  end
end
