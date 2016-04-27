require 'rails_helper'

feature 'Admin can delete an existing <%= model_configuration.as_constant %>' do

  sign_in_as(:admin)
  <%= Frontier::FeatureSpec::TargetObjectLetStatement.new(model_configuration).to_s %>

  before do
    visit(<%= model_configuration.url_builder.index_path(show_nested_model_as_ivar: false) %>)
  end

  scenario do
    within_row(<%= model_configuration.model_name %>.<%= model_configuration.primary_attribute.name %>) do
      click_link("Delete")
    end

    expect(page).to have_flash(:notice)
    expect(page).not_to have_content(<%= model_configuration.model_name %>.<%= model_configuration.primary_attribute.name %>)
    # Ensure object is deleted
    expect(<%= model_configuration.model_name %>.reload).to be_deleted
  end
end
