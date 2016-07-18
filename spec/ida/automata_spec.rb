require_relative "../../lib/ida/automata"

describe Ida::Automata do

  subject(:instance) { described_class.new }

  describe "#transition!" do

    context "when the given character causes a state transition" do

      xit "transitions the automata" do
      end

      xit "returns true" do
      end
    end

    context "when the given character does not cause a state transition" do

      xit "it does not transition" do
      end

      xit "returns false" do
      end
    end
  end

  describe "#reset!" do

    context "when the automata is not at it's start state" do

      xit "gets reset to it's start state" do
      end
    end
  end

  describe "#create_token_unless_whitespace" do

    context "when the token is whitespace" do
      xit "does not attempt to create a token" do
      end

      xit "returns nil" do
      end
    end

    context "when the token is NOT whitespace" do

      xit "attempts to create a token" do
      end

      context "when the token could not be created" do

        xit "blows up" do
        end
      end
    end
  end
end
