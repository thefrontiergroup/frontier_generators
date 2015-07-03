require 'spec_helper'

describe ModelConfiguration::Attribute::Validation::Factory do

  let(:factory) { ModelConfiguration::Attribute::Validation::Factory.new }
  let(:attribute) { ModelConfiguration::Attribute.new(build_model_configuration, "who_cares", {}) }

  describe "build" do
    subject { factory.build(attribute, key, args) }
    let(:args) { {} }

    context "when key is 'numericality'" do
      let(:key) { "numericality" }
      it { should be_kind_of(ModelConfiguration::Attribute::Validation::Numericality) }
    end

    context "when key is not one of the above cases" do
      let(:key) { "presence" }
      it { should be_kind_of(ModelConfiguration::Attribute::Validation) }
    end
  end

end
