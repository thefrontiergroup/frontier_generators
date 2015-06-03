require 'spec_helper'

feature 'Admin can create a new <%= model_configuration.as_constant %>' do

  sign_in_as(:admin)
<% model_configuration.attributes.select(&:is_association?).each do |attribute| -%>
  let!(<%= attribute.as_symbol %>) { FactoryGirl.create(:<%= attribute.properties[:class_name].underscore || attribute.name %>) }
<% end -%>

  before do
    visit(<%= model_configuration.url_builder.index_path %>)
    click_link("Add new <%= model_configuration.as_constant.titleize %>")
  end

  scenario 'Admin creates <%= model_configuration.as_constant %> with valid data' do
    attributes = FactoryGirl.attributes_for(<%= model_configuration.as_symbol %>)
    fill_in_form("<%= model_configuration.model_name %>", attributes)
<% model_configuration.attributes.select(&:is_association?).each do |attribute| -%>
    select(<%= attribute.name %>, from: "<%= attribute.capitalized %>")
<% end -%>

    submit_form

    target_object = <%= model_configuration.as_constant %>.order(:created_at).first
    expect(target_object).to have_attributes(attributes)
  end
end