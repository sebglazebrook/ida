require_relative "../../lib/ida/lexical_analyzer"
require_relative "../../lib/ida/tokens/number"
require_relative "../../lib/ida/automata"
require_relative "../../lib/ida/token_factory"

describe Ida::LexicalAnalyzer do

  describe ".analyze" do

    subject { described_class.new.analyze(raw_source_code) }

    let(:raw_source_code) { "123" }
    let(:automata_double) { instance_double("Ida::Automata") }

    let(:token) { Ida::Tokens::Number.new("123") }

    before do
      allow(Ida::Automata).to receive(:new).and_return(automata_double)
      allow(automata_double).to receive(:create_token_unless_whitespace).and_return(token)
      allow(automata_double).to receive(:transition!).with("1").and_return(true)
      allow(automata_double).to receive(:transition!).with("2").and_return(true)
      allow(automata_double).to receive(:transition!).with("3").and_return(true)
    end

    it "transitons the automata through each character of the source code" do
      expect(automata_double).to receive(:transition!).with("1").and_return(true)
      expect(automata_double).to receive(:transition!).with("2").and_return(true)
      expect(automata_double).to receive(:transition!).with("3").and_return(true)
      subject
    end

    it "returns the token" do
      expect(subject).to eq(token)
    end

    context "when the end of input is reached" do

      let(:raw_source_code) { "1" }
      let(:token) { Ida::Tokens::Number.new("1") }

      before do
        allow(automata_double).to receive(:transition!).with("1").and_return(true)
      end

      it "creates a token" do
        expect(automata_double).to receive(:create_token_unless_whitespace).and_return(token)
        subject
      end

      it "returns the token" do
        expect(subject).to eq(token)
      end

      context "when no non whitespace token could be created" do

        let(:raw_source_code) { " 1" }

        before do
          allow(automata_double).to receive(:transition!).with(" ")
          allow(automata_double).to receive(:transition!).with("1")
          allow(automata_double).to receive(:reset!)
          allow(automata_double).to receive(:create_token_unless_whitespace).and_return(nil, token)
        end

        it "resets the automata" do
          expect(automata_double).to receive(:reset!)
          subject
        end

        it "finds the next one" do
          expect(subject).to eq(token)
        end
      end
    end
  end
end
