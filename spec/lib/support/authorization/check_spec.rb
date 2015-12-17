require 'spec_helper'

describe Frontier::Authorization::Check do

  describe "#to_s" do
    subject { authorize_check.to_s }
    let(:authorize_check) { Frontier::Authorization::Check.new(model_configuration, action) }
    let(:model_configuration) { ModelConfiguration.new(attributes) }
    let(:attributes) { {test_model: {authorization: authorization}}.stringify_keys }

    context "when using Pundit" do
      let(:authorization) { "pundit" }

      context "and the action is new" do
        let(:action) { :new }
        it { should eq("policy(TestModel).new?") }
      end

      context "and the action is not new" do
        let(:action) { :edit }
        it { should eq("policy(@test_model).edit?") }
      end
    end

    context "when using CanCanCan" do
      let(:authorization) { "cancancan" }

      context "and the action is new" do
        let(:action) { :new }
        it { should eq("can?(:new, TestModel)") }
      end

      context "and the action is not new" do
        let(:action) { :edit }
        it { should eq("can?(:edit, @test_model)") }
      end
    end
  end

end
