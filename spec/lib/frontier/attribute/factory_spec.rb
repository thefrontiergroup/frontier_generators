require 'spec_helper'

describe Frontier::Attribute::Factory do

  describe ".build_attribute_or_association" do
    subject { Frontier::Attribute::Factory.build_attribute_or_association(build_model_configuration, name, options) }
    let(:name)    { "field_name" }
    let(:options) { {type: type} }

    context "when type is an association type" do
      [
        "belongs_to",
        "has_one",
        "has_many",
        "has_and_belongs_to_many"
      ].each do |association_type|
        context "when type is #{association_type}" do
          let(:type) { association_type }
          it { should be_kind_of(Frontier::Association) }
        end
      end
    end

    context "when type is not an association type" do
      let(:type) { "string" }
      it { should be_kind_of(Frontier::Attribute) }
    end
  end

end
