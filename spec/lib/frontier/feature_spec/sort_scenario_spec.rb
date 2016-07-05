require 'spec_helper'

describe Frontier::FeatureSpec::SortScenario do

  describe "#to_s" do
    subject { sort_scenario.to_s }

    let(:sort_scenario) { Frontier::FeatureSpec::SortScenario.new(attribute) }
    let(:model_configuration) { build_model_configuration }
    let(:attribute)           { model_configuration.attributes.first }

    let(:expected) do
      raw = <<STRING
scenario "sorting by 'Name'" do
  first  = FactoryGirl.create(:test_model, name: "Alpha")
  second = FactoryGirl.create(:test_model, name: "Bravo")

  visit_index

  # Ascending
  click_link("Name")
  expect_test_models_to_be_ordered(first, second)

  # Descending
  click_link("Name")
  expect_test_models_to_be_ordered(second, first)
end
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
