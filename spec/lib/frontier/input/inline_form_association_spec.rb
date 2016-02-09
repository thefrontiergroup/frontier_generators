require 'spec_helper'

describe Frontier::Input::InlineFormAssociation do

  let(:input_implementation) { Frontier::Input::InlineFormAssociation.new(association) }
  let(:association) { Frontier::Association.new(build_model_configuration, name, options) }
  let(:name) { "association_name_id" }
  let(:options) { {} }

  describe "#to_s" do
    subject { input_implementation.to_s(input_options) }
    let(:input_options) { {} }

    context "with no attributes passed through" do
      let(:expected) do
        <<-CODE
f.simple_fields_for(:association_name) do |ff|

end
CODE
      end

      it { should eq(expected) }
    end

    context "with some attributes passed through" do
      let(:options) do
        {
          attributes: {
            name: {type: "string"},
            other_association: {type: "belongs_to"}
          }
        }
      end
      let(:expected) do
        <<-CODE
f.simple_fields_for(:association_name) do |ff|
  ff.input :name
  ff.association :other_association, collection: OtherAssociation.all
end
CODE
      end

      it { should eq(expected) }
    end
  end

end
