require 'spec_helper'

describe Frontier::Input::Association do

  let(:input_implementation) { Frontier::Input::Association.new(association) }
  let(:association) { Frontier::Association.new(build_model_configuration, name, options) }
  let(:name) { "association_name_id" }
  let(:options) { {form_type: form_type} }

  describe "#to_s" do
    subject { input_implementation.to_s(input_options) }
    let(:input_options) { {} }

    context "when form_type is 'inline'" do
      let(:form_type) { "inline" }

      it "delegates to the Frontier::Input::InlineFormAssociation" do
        expect_any_instance_of(Frontier::Input::InlineFormAssociation).to receive(:to_s)
        subject
      end
    end

    context "when form_type is 'select'" do
      let(:form_type) { "select" }

      it "delegates to the Frontier::Input::SelectFormAssociation" do
        expect_any_instance_of(Frontier::Input::SelectFormAssociation).to receive(:to_s)
        subject
      end
    end
  end

end
