require_relative "../../lib/ida/automata"

describe Ida::Automata do

  let(:transition_data) do
    {
      :"0" => {
        "1" => 1,
        "3" => 1
    },
      :"1" => { "2" => 1 }
    }
  end
  let(:instance) { described_class.new(transition_data) }

  describe "#transition!" do

    subject { instance.transition!(char) }

    context "when the given character causes a state transition on a first match" do

      let(:char) { "1" }

      it "transitions the automata" do
        expect(subject.current_state).to eq(1)
      end
    end

    context "when the given character causes a state transition on a NON first match" do

      let(:char) { "3" }

      it "transitions the automata" do
        expect(subject.current_state).to eq(1)
      end
    end

    context "when the given character does not cause a state transition" do

      let(:char) { "4" }

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
    let(:transition_data) do
      {
        :"0" => { " " => 1, name: :start_state },
        :"1" => { " " => 1, name: :whitespace, accepted: true }
      }
    end

    subject { instance.create_token_unless_whitespace }

    context "when the current state is not an accepted state" do

      it "blows up" do
        expect{subject}.to raise_error(Ida::Automata::UnacceptedStateError )
      end
    end

    context "when the current state is an accepted state" do

      context "and the token is whitespace" do

        before do
          instance.transition!(" ")
        end

        it "does not attempt to create a token" do
          expect(Ida::TokenFactory).to_not receive(:create)
          subject
        end

        it "returns nil" do
          expect(subject).to eq nil
        end
      end

      context "and the token is NOT whitespace" do

        let(:transition_data) do
          {
            :"0" => { "1" => 1, name: :start_state },
            :"1" => { "2" => 1, name: :number, accepted: true }
          }
        end
        let(:token) { instance_double("Ida::Token") }

        before do
          instance.transition!("1")
          instance.transition!("2")
          allow(Ida::TokenFactory).to receive(:create).with(:number, "12").and_return(token)
        end

        it "creates the token" do
          expect(Ida::TokenFactory).to receive(:create).with(:number, "12").and_return(token)
          subject
        end

        it "returns the token" do
          expect(subject).to eq token
        end

        context "and the token could not be created" do

          before do
            allow(Ida::TokenFactory).to receive(:create).with(:number, "12").and_return(nil)
          end

          it "blows up" do
            expect{subject}.to raise_error(Ida::Automata::InvalidTokenError)
          end
        end
      end
    end
  end
end
