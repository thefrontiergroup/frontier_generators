require 'spec_helper'

describe Frontier::FeatureSpec::TargetObjectLetStatement do

  describe "#to_s" do
    subject { Frontier::FeatureSpec::TargetObjectLetStatement.new(model_configuration).to_s }
    let(:model_configuration) { Frontier::ModelConfiguration.new({model_name: {}}) }

    it { should eq("let!(:model_name) { FactoryGirl.create(:model_name) }") }
  end

end
