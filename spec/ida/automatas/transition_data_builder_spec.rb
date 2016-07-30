require "yaml"
require_relative "../../../lib/ida/automatas/transition_data_builder"

describe Ida::Automatas::TransitionDataBuilder do

  subject(:instance) { described_class.new }

  describe "#from_regex" do

    let(:name) { "any old name" }
    let(:regex) { /abc123/ }
    let(:enumerable_regexes) { Array.new }

    subject { instance.from_regex(regex, name) }

    before do
      allow(Ida::Automatas::EnumerableRegexFactory).to receive(:create).with(regex).and_return(enumerable_regexes)
    end

    it "creates EnumerableRegexes" do
      expect(Ida::Automatas::EnumerableRegexFactory).to receive(:create).with(regex).and_return(enumerable_regexes)
      subject
    end

    it "adds the EnumerableRegexes to the regex collection" do
      subject
      expect(instance.regexes[name]).to eq enumerable_regexes
    end
  end

  describe "#build" do

    subject { instance.build }

    it "generates the transition data file" do
      subject
      expect(File.exist?(instance.class::OUTPUT_PATH)).to be true
    end

    describe "the transition data file contents" do

      let(:transition_data) { YAML.load_file(instance.class::OUTPUT_PATH) }

      context "when there is one regex" do

        let(:expected_data) do
          {
            :"0" => { "a" => 1, name: :start_state },
            :"1" => { "a" => 1, name: :a, accepted: true }
          }
        end

        before do
          instance.from_regex(/aa/, :a)
        end

        it "has transition data to go from start state to accepted state" do
          subject
          expect(transition_data).to eq(expected_data)
        end
      end

      context "when there are multiple regexes" do

        before do
          instance.from_regex(//, :number)
          instance.from_regex(//, :identifier)
        end

        context "for the first regex" do
          xit "has transition data to go from start state to accepted state" do
          end
        end

        context "for further regexes" do
          xit "has transition data to go from start state to accepted state" do
          end
        end
      end
    end
  end
  xit "handles when there are two names for an accepted state"
end
