require 'spec_helper'

describe Frontier::FeatureSpec::SortScenario do

  describe "#to_s" do
    subject { sort_scenario.to_s }

    let(:sort_scenario) { Frontier::FeatureSpec::SortScenario.new(model_configuration, attribute) }
    let(:model_configuration) { build_model_configuration }
    let(:attribute)           { model_configuration.attributes.first }

    let(:expected) do
      raw = <<STRING
scenario "sorting by 'name'" do
  second = FactoryGirl.create(:test_model, name: "Bravo")
  first  = FactoryGirl.create(:test_model, name: "Alpha")

  visit_index

  # Descending
  click_link("Name")
  expect_test_models_to_be_ordered(second, first)

  # Ascending
  click_link("Name")
  expect_test_models_to_be_ordered(first, second)
end
STRING
      raw.rstrip
    end

    it { should eq(expected) }
  end

end
