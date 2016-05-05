require 'spec_helper'

describe Frontier::Attribute::Validation::Factory do

  let(:factory) { Frontier::Attribute::Validation::Factory.new }
  let(:attribute) { Frontier::Attribute.new(build_model_configuration, "who_cares", {}) }

  describe "build" do
    subject { factory.build(attribute, key, args) }
    let(:args) { {} }

    context "when key is 'length'" do
      let(:key) { "length" }
      it { should be_kind_of(Frontier::Attribute::Validation::Length) }
    end

    context "when key is 'numericality'" do
      let(:key) { "numericality" }
      it { should be_kind_of(Frontier::Attribute::Validation::Numericality) }
    end

    context "when key is not one of the above cases" do
      let(:key) { "presence" }
      it { should be_kind_of(Frontier::Attribute::Validation) }
    end

    context "when key is 'uniqueness'" do
      let(:key) { "uniqueness" }
      it { should be_kind_of(Frontier::Attribute::Validation::Uniqueness) }
    end
  end

end
