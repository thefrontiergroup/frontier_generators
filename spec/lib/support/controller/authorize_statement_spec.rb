require 'spec_helper'

describe Frontier::Controller::AuthorizeStatement do

  describe "#to_s" do
    subject { authorize_statement.to_s }
    let(:authorize_statement) { Frontier::Controller::AuthorizeStatement.new(model_configuration, action) }
    let(:model_configuration) { ModelConfiguration.new(attributes) }
    let(:attributes) { {test_model: {authorization: authorization}}.stringify_keys }

    context "when using Pundit" do
      let(:action) { :index }
      let(:authorization) { "pundit" }

      it { should eq("authorize(TestModel)") }
    end

    context "when using CanCanCan" do
      let(:authorization) { "cancancan" }

      context "and the action is index" do
        let(:action) { :index }
        it { should eq("authorize!(:index, TestModel)") }
      end

      context "and the action is not index" do
        let(:action) { :show }
        it { should eq("authorize!(:show, @test_model)") }
      end
    end
  end

end
