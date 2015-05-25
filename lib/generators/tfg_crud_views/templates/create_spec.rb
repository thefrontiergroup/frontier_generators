require 'spec_helper'

feature 'Admin can create a new <%= model_configuration.as_constant %>' do

  sign_in_as(:admin)

  before do
    visit(<%= model_configuration.url_builder.index_path %>)
    click_link("Add new <%= model_configuration.as_constant %>")
  end

  scenario 'Admin creates <%= model_configuration.as_constant %> with valid data' do
    attributes = FactoryGirl.attributes_for(<%= model_configuration.as_symbol %>)
    fill_in_form("<%= model_configuration.model_name %>", attributes)

    submit_form

    target_object = <%= model_configuration.as_constant %>.order(:created_at).first
    ensure_attributes_were_updated(target_object, attributes)
  end

  scenario 'Admin creates <%= model_configuration.as_constant %> with invalid data' do
    attributes = FactoryGirl.attributes_for(<%= model_configuration.as_symbol %>, :invalid)
    fill_in_form("<%= model_configuration.model_name %>", attributes)

    submit_form
    expect(<%= model_configuration.as_constant %>.count).to eq(0)
  end
end
