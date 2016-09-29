require 'spec_helper'

describe Frontier::ControllerSpec::SubjectBlock do

  describe "#to_s" do
    subject { subject_block.to_s }
    let(:subject_block) do
      Frontier::ControllerSpec::SubjectBlock.new(
        model,
        method,
        action,
        params
      )
    end

    let(:method) { :get }
    let(:action) { :index }
    let(:params) { {} }

    context "with no additional arguments and no nested models" do
      let(:model) { build_model }

      it { should eq("subject { get :index }") }
    end

    context "with some additional arguments" do
      let(:model) { build_model }
      let(:params) { {user: "attributes"} }

      it { should eq("subject { get :index, user: attributes }") }
    end

    context "with some nested models" do
      let(:model) do
        Frontier::Model.new({
          model_name: {
            controller_prefixes: ["@user", "@cat"]
          }
        })
      end
      let(:params) { {user: "attributes"} }

      let(:expected) do
        "subject { get :index, cat_id: cat.id, user_id: user.id, user: attributes }"
      end

      it { should eq(expected) }
    end

  end

end
