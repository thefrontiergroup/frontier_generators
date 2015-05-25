require 'spec_helper'

feature 'Admin can update an existing <%= model_configuration.as_constant %>' do

  sign_in_as(:admin)
  let!(:target_object) { FactoryGirl.create(<%= model_configuration.as_symbol %>) }

  before do
    visit(<%= model_configuration.url_builder.index_path %>)
    within_row(target_object.<%= model_configuration.attributes.first.name %>) do
      click_link("Edit")
    end
  end

  scenario 'Admin updates user with valid data' do
    attributes = FactoryGirl.attributes_for(<%= model_configuration.as_symbol %>)
    fill_in_form("<%= model_configuration.model_name %>", attributes)

    submit_form

    ensure_attributes_were_updated(target_object, attributes)
  end

  scenario 'Admin updates user with invalid data' do
    attributes = FactoryGirl.attributes_for(<%= model_configuration.as_symbol %>, :invalid)
    fill_in_form("<%= model_configuration.model_name %>", attributes)

    submit_form

    expect(current_path).to eq(<%= model_configuration.url_builder.failed_edit_path('target_object') %>)
  end
end
