require 'spec_helper'

describe Frontier::Model::Name do

  let(:name) { Frontier::Model::Name.new("test_model") }

  describe "#as_plural" do
    subject { name.as_plural }
    it { should eq("test_models") }
  end

  describe "#as_singular" do
    subject { name.as_singular }
    it { should eq("test_model") }
  end

  describe "#as_singular_with_spaces" do
    subject { name.as_singular_with_spaces }
    it { should eq("test model") }
  end

  describe "#as_constant" do
    subject { name.as_constant }
    it { should eq("TestModel") }
  end

  describe "#as_plural_ivar" do
    subject { name.as_plural_ivar }
    it { should eq("@test_models") }
  end

  describe "#as_singular_ivar" do
    subject { name.as_singular_ivar }
    it { should eq("@test_model") }
  end

  describe "#as_symbol" do
    subject { name.as_symbol }
    it { should eq(":test_model") }
  end

  describe "#as_plural_symbol" do
    subject { name.as_plural_symbol }
    it { should eq(":test_models") }
  end

  describe "#as_title" do
    subject { name.as_title }
    it { should eq("Test Model") }
  end

end
