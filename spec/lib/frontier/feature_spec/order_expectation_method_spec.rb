require 'spec_helper'

describe Frontier::FeatureSpec::OrderExpectationMethod do

  describe '#method_name' do
    subject { order_expectation_method.method_name }
    let(:order_expectation_method) { Frontier::FeatureSpec::OrderExpectationMethod.new(build_model_configuration) }

    it { should eq("expect_test_models_to_be_ordered") }
  end

end
