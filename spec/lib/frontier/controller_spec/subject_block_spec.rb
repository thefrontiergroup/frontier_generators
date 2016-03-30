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

  end

end
