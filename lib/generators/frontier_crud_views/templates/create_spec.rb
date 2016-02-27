require 'rails_helper'

feature 'Admin can create a new <%= model_configuration.as_constant %>' do

  sign_in_as(:admin)
<%= render_with_indent(1, Frontier::SpecSupport::ObjectSetup::AttributesSetup.new(model_configuration).to_s) %>
<%= render_with_indent(1, Frontier::SpecSupport::ObjectSetup::AssociatedModelSetup.new(model_configuration).to_s) %>

  before do
    visit(<%= model_configuration.url_builder.index_path %>)
    click_link("Add new <%= model_configuration.as_title %>")
  end

  scenario 'Admin creates <%= model_configuration.as_constant %> with valid data' do
    attributes = FactoryGirl.attributes_for(<%= model_configuration.as_symbol %>)
<% model_configuration.attributes.each do |attribute| -%>
    <%= Frontier::FeatureSpecAssignment.new(attribute).to_s %>
<% end -%>

    submit_form

    <%= model_configuration.model_name %> = <%= model_configuration.as_constant %>.order(created_at: :desc).first
<%= render_with_indent(2, Frontier::SpecSupport::ObjectAttributesAssertion.new(model_configuration).to_s) %>
  end
end
