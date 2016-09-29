require 'spec_helper'

describe Frontier::FeatureSpec::SortScenario::OrderedObject do

  let(:ordered_object) { Frontier::FeatureSpec::SortScenario::OrderedObject.new(attribute) }
  let(:model) do
    Frontier::Model.new({
      test_model: {
        attributes: {name: {type: type}}
      }
    })
  end
  let(:attribute) { model.attributes.first }

  context "when 'boolean'" do
    let(:type) { "boolean" }

    specify { expect(ordered_object.first).to eq("FactoryGirl.create(:test_model, name: false)") }
    specify { expect(ordered_object.second).to eq("FactoryGirl.create(:test_model, name: true)") }
  end

  context "when 'datetime'" do
    let(:type) { "datetime" }

    specify { expect(ordered_object.first).to eq("FactoryGirl.create(:test_model, name: 10.days.ago)") }
    specify { expect(ordered_object.second).to eq("FactoryGirl.create(:test_model, name: 5.days.ago)") }
  end

  context "when 'date'" do
    let(:type) { "date" }

    specify { expect(ordered_object.first).to eq("FactoryGirl.create(:test_model, name: 10.days.ago)") }
    specify { expect(ordered_object.second).to eq("FactoryGirl.create(:test_model, name: 5.days.ago)") }
  end

  context "when 'decimal'" do
    let(:type) { "decimal" }

    specify { expect(ordered_object.first).to eq("FactoryGirl.create(:test_model, name: 10)") }
    specify { expect(ordered_object.second).to eq("FactoryGirl.create(:test_model, name: 100)") }
  end

  context "when 'integer'" do
    let(:type) { "integer" }

    specify { expect(ordered_object.first).to eq("FactoryGirl.create(:test_model, name: 10)") }
    specify { expect(ordered_object.second).to eq("FactoryGirl.create(:test_model, name: 100)") }
  end

  context "when string" do
    let(:type) { "string" }

    specify { expect(ordered_object.first).to eq("FactoryGirl.create(:test_model, name: \"Alpha\")") }
    specify { expect(ordered_object.second).to eq("FactoryGirl.create(:test_model, name: \"Bravo\")") }
  end

  context "when 'text'" do
    let(:type) { "text" }

    specify { expect(ordered_object.first).to eq("FactoryGirl.create(:test_model, name: \"Alpha\")") }
    specify { expect(ordered_object.second).to eq("FactoryGirl.create(:test_model, name: \"Bravo\")") }
  end

  context "when an unsupported type" do
    let(:type) { "donkey" }

    specify { expect(ordered_object.first).to eq("FactoryGirl.create(:test_model, name: \"Alpha\")") }
    specify { expect(ordered_object.second).to eq("FactoryGirl.create(:test_model, name: \"Bravo\")") }
  end


end
