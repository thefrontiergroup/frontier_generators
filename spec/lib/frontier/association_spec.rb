require 'spec_helper'

describe Frontier::Association do

  let(:association) { Frontier::Association.new(build_model, name, options) }
  let(:name) { "association_name" }
  let(:options) { {} }

  describe "#initialize" do
    subject(:initialize_association) { association }

    describe "parsing attributes" do
      let(:options) { {attributes: {name: {type: "string"}}} }

      it "can parse attributes" do
        expect(association.attributes.count).to eq(1)
        expect(association.attributes.first.name).to eq("name")
        expect(association.attributes.first.type).to eq("string")
      end
    end

    describe "parsing form_type" do
      subject { initialize_association.form_type }
      let(:options) { {form_type: form_type} }

      context "when 'inline'" do
        let(:form_type) { "inline" }
        it { should eq("inline") }
      end

      context "when 'select'" do
        let(:form_type) { "select" }
        it { should eq("select") }
      end

      context "when something blank" do
        let(:form_type) { "" }
        it { should eq("select") }
      end

      context "when something unexpected" do
        let(:form_type) { "jordan_rules" }
        it { should eq("select") }
      end
    end

    describe "setting name" do
      context "when name doesn't contain _id" do
        let(:name) { "address" }
        it "returns the name" do
          expect(association.name).to eq("address")
        end
      end

      context "when name contains _id" do
        let(:name) { "address_id" }
        it "strips the id from the name" do
          expect(association.name).to eq("address")
        end
      end
    end
  end

  describe "#as_factory_name" do
    subject { association.as_factory_name }

    context "with class_name declared" do
      let(:expected_output) { ":dong" }
      let(:options) { {class_name: "Dong"} }

      it { should eq(expected_output) }
    end

    context "without class_name declared" do
      let(:expected_output) { ":model" }

      context "when field_name includes _id already" do
        let(:name) { "model_id" }
        it { should eq(expected_output) }
      end

      context "when field_name doesn't include _id" do
        let(:name) { "model" }
        it { should eq(expected_output) }
      end
    end
  end

  describe "#as_field_name" do
    subject { association.as_field_name }

    context "when field_name includes _id already" do
      let(:name) { "model_id" }
      it { should eq(":model_id") }
    end

    context "when field_name doesn't include _id" do
      let(:name) { "model" }
      it { should eq(":model_id") }
    end
  end

  describe "#as_symbol" do
    subject { association.as_symbol }

    context "when field_name includes _id already" do
      let(:name) { "model_id" }
      it { should eq(":model") }
    end

    context "when field_name doesn't include _id" do
      let(:name) { "model" }
      it { should eq(":model") }
    end
  end

  describe "#is_association?" do
    subject { association.is_association? }
    it { should eq(true) }
  end

  describe "#is_nested?" do
    subject { association.is_nested? }
    let(:options) { {form_type: form_type} }

    context "when form is 'inline'" do
      let(:form_type) { "inline" }
      it { should eq(true) }
    end

    context "when form is 'select'" do
      let(:form_type) { "select" }
      it { should eq(false) }
    end

  end

end
