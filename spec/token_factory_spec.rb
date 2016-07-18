describe Ida::TokenFactory do

  describe ".create" do

    subject { described_class.create(type, value) }

    context "when given a number" do

      let(:type) { :number }
      let(:value) { "123" }

      it "creates a number" do
        expect(subject).to be_kind_of Ida::Tokens::Number
        expect(subject.value_equals?("123")).to eq true
      end
    end
  end
end
