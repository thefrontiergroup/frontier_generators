require 'spec_helper'

describe Frontier::Controller::AuthorizeScope do

  describe "#to_s" do
    subject { authorize_scope.to_s }
    let(:authorize_scope)     { Frontier::Controller::AuthorizeScope.new(model_configuration) }
    let(:model_configuration) { ModelConfiguration.new(attributes) }
    let(:attributes) { {test_model: {authorization: authorization}}.stringify_keys }

    context "when using Pundit" do
      let(:authorization) { "pundit" }
      it { should eq("policy_scope(TestModel.all)") }
    end

    context "when using CanCanCan" do
      let(:authorization) { "cancancan" }
      it { should eq("TestModel.all") }
    end
  end

end
