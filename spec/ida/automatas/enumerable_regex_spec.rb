require_relative "../../../lib/ida/automatas/enumerable_regex"

describe Ida::Automatas::EnumerableRegex do

  subject(:instance) { described_class.new(raw_regex) }

  describe "#each" do

    subject { instance.each }

    context "when given a simple character based regex" do

      let(:raw_regex) { /abc/ }

      it "iterates through each character of the regex" do
        expect(subject.next).to eq "a"
        expect(subject.next).to eq "b"
        expect(subject.next).to eq "c"
      end
    end

    context "when given a complex character group regex" do
      
      xit "iterates through each character/group of the regex" do
      end
    end
  end
end
