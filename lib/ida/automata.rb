module Ida
  class Automata

    attr_reader :current_state

    def initialize(transition_data = {})
      @transition_data = transition_data
      @current_state = 0
    end

    def transition!(character)
      if @transition_data[@current_state.to_s.to_sym][:match] == character
        @current_state = @transition_data[@current_state.to_s.to_sym][:transition]
        self
      else
        false
      end
    end

    def reset!
      @current_state = 0
      self
    end

    def create_token_unless_whitespace
    end

  end
end
