require_relative "../../lib/ida/automata"

describe Ida::Automata do

  let(:transition_data) do
    {
      :"0" => { match: "1", transition: 1 },
      :"1" => { match: "2", transition: 1 }
    }
  end
  let(:instance) { described_class.new(transition_data) }

  describe "#transition!" do

    subject { instance.transition!(char) }

    context "when the given character causes a state transition" do

      let(:char) { "1" }

      it "transitions the automata" do
        expect(subject.current_state).to eq(1)
      end
    end

    context "when the given character does not cause a state transition" do

      let(:char) { "3" }

      it "it does not transition" do
        subject
        expect(instance.current_state).to eq(0)
      end

      it "returns false" do
        expect(subject).to eq(false)
      end
    end
  end

  describe "#reset!" do

    subject { instance.reset! }

    before do
      instance.transition!("1")
    end

    context "when the automata is not at it's start state" do

      it "gets reset to it's start state" do
        expect(subject.current_state).to eq(0)
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
