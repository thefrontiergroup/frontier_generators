require 'spec_helper'

RSpec.describe Frontier::SpecSupport::LetStatement do

  describe "#to_s" do
    subject { Frontier::SpecSupport::LetStatement.new("jordan", "rules").to_s(options) }
    let(:options) do
      {
        has_bang: has_bang,
        is_multiline: is_multiline
      }
    end
    let(:has_bang)     { false }
    let(:is_multiline) { false }

    describe "including a bang" do
      context "when has_bang" do
        let(:has_bang) { true }
        it { should eq("let!(:jordan) { rules }") }
      end

      context "when !has_bang" do
        let(:has_bang) { false }
        it { should eq("let(:jordan) { rules }") }
      end
    end

    describe "rendering as multiline" do
      context "when is_multiline" do
        let(:is_multiline) { true }
        let(:expected) do
          raw = <<TEXT
let(:jordan) do
  rules
end
TEXT
          raw.rstrip
        end

        it { should eq(expected) }
      end

      context "whe !is_multiline" do
        let(:is_multiline) { false }
        it { should eq("let(:jordan) { rules }") }
      end
    end
  end

end
