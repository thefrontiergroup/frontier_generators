require 'spec_helper'

RSpec.describe Frontier::SpecSupport::LetStatement do

  describe "#to_s" do
    subject { Frontier::SpecSupport::LetStatement.new("jordan", "rules").to_s(has_bang) }

    context "when has_bang" do
      let(:has_bang) { true }
      it { should eq("let!(:jordan) { rules }") }
    end

    context "when !has_bang" do
      let(:has_bang) { false }
      it { should eq("let(:jordan) { rules }") }
    end
  end

end
