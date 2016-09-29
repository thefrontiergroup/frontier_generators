require 'spec_helper'

describe Frontier::FeatureSpec::OrderExpectationMethod do

  describe '#method_name' do
    subject { order_expectation_method.method_name }
    let(:order_expectation_method) { Frontier::FeatureSpec::OrderExpectationMethod.new(build_model) }

    it { should eq("expect_test_models_to_be_ordered") }
  end

  describe "#to_s" do
    subject { order_expectation_method.to_s }

    let(:order_expectation_method) { Frontier::FeatureSpec::OrderExpectationMethod.new(model) }
    let(:model) { build_model }

    let(:expected) do
      raw = <<STRING
def expect_test_models_to_be_ordered(first, second)
  within(first_row)  { expect(page).to have_content(first.name) }
  within(second_row) { expect(page).to have_content(second.name) }
end
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
