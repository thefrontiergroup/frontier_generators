require 'spec_helper'

describe Frontier::Authorization::Check do

  describe "#to_s" do
    subject { authorize_check.to_s }
    let(:authorize_check)     { Frontier::Authorization::Check.new(model_configuration, object, action) }
    let(:model_configuration) { Frontier::ModelConfiguration.new(attributes) }
    let(:attributes)          { {test_model: {authorization: authorization}}.stringify_keys }

    context "when using Pundit" do
      let(:authorization) { "pundit" }
      let(:object) { "TestModel" }
      let(:action) { :new }

      it { should eq("policy(TestModel).new?") }
    end

    context "when using CanCanCan" do
      let(:authorization) { "cancancan" }
      let(:object) { "TestModel" }
      let(:action) { :new }

      it { should eq("can?(:new, TestModel)") }
    end
  end

end
