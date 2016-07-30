require_relative "../../lib/ida/token_factory"

module Ida
  class Automata
    class UnacceptedStateError < StandardError; end
    class InvalidTokenError < StandardError; end

    attr_reader :current_states

    def initialize(transition_data = {})
      @transition_data = transition_data
      @current_states = [0]
      @current_string = ""
    end

    def transition!(character)
      if transitionable?(character)
        transition_all_transitionable_states(character)
        self
      else
        false
      end
    end

    def reset!
      @current_states = [0]
      @current_string = ""
      self
    end

    def create_token_unless_whitespace
      raise UnacceptedStateError if @current_states.first.nil?
      raise UnacceptedStateError unless @transition_data[@current_states.first.to_s.to_sym][:accepted]
      unless @transition_data[@current_states.first.to_s.to_sym][:name] == :whitespace
        token = TokenFactory.create(@transition_data[@current_states.first.to_s.to_sym][:name], @current_string)
        token ? token : raise(InvalidTokenError)
      end
    end

    private

    def transitionable?(character)
      current_states.any? do |key|
        @transition_data[key.to_s.to_sym].keys.include?(character)
      end
    end

    def transition_all_transitionable_states(character)
      @current_string += character
      new_states = []
      current_states.each do |key|
        new_states << @transition_data[key.to_s.to_sym][character]
      end
      @current_states = new_states.flatten.compact
    end

  end
end
