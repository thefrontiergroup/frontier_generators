require 'spec_helper'

feature 'Admin can delete an existing <%= model_configuration.as_constant %>' do

  sign_in_as(:admin)
  let!(:target_object) { FactoryGirl.create(<%= model_configuration.as_symbol %>) }

  before do
    visit(<%= model_configuration.url_builder.index_path %>)
  end

  scenario 'Admin can delete <%= model_configuration.model_name.pluralize %>' do
    within_row(target_object.<%= model_configuration.primary_attribute.name %>) do
      click_link("Delete")
    end

    # Ensure object is deleted
    expect(<%= model_configuration.as_constant %>.count).to eq(0)
    expect(page).to have_flash(:notice)
    expect(page).not_to have_content(target_object.<%= model_configuration.primary_attribute.name %>)
  end
end