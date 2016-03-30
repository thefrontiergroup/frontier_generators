require 'spec_helper'

describe Frontier::ControllerSpec::SubjectBlock do

  describe "#to_s" do
    subject { subject_block.to_s }
    let(:subject_block) do
      Frontier::ControllerSpec::SubjectBlock.new(
        model_configuration,
        method,
        action,
        params
      )
    end

    let(:method) { :get }
    let(:action) { :index }
    let(:params) { {} }

    context "with no additional arguments and no nested models" do
      let(:model_configuration) { build_model_configuration }

      it { should eq("subject { get :index }") }
    end

    context "with some additional arguments" do
      let(:model_configuration) { build_model_configuration }
      let(:params) { {user: "attributes"} }

      it { should eq("subject { get :index, user: attributes }") }
    end

    context "with some nested models" do
      let(:model_configuration) do
        Frontier::ModelConfiguration.new({
          model_name: {
            controller_prefixes: ["@user", "@cat"]
          }
        })
      end
      let(:params) { {user: "attributes"} }

      let(:expected) do
        raw = <<STRING
subject { get :index, cat_id: cat.id, user_id: user.id, user: attributes }
let(:cat) { FactoryGirl.create(:cat) }
let(:user) { FactoryGirl.create(:user) }
STRING
        raw.rstrip
      end

      it { should eq(expected) }
    end

  end

end
