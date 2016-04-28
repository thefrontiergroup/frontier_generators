require 'rails_helper'

feature 'Admin can create a new <%= model_configuration.as_constant %>' do

  sign_in_as(:admin)
<%= render_with_indent(1, Frontier::FeatureSpec::TargetObjectLetStatement.new(model_configuration).to_s(include_resource: false)) %>
<%= render_with_indent(1, Frontier::SpecSupport::ObjectSetup::AttributesSetup.new(model_configuration).to_s) %>
<%= render_with_indent(1, Frontier::SpecSupport::ObjectSetup::AssociatedModelSetup.new(model_configuration).to_s) %>

  before do
    visit(<%= model_configuration.url_builder.index_path(show_nested_model_as_ivar: false) %>)
    click_link("Add a <%= model_configuration.as_title %>")
  end

  scenario 'with valid data' do
<%= render_with_indent(2, Frontier::SpecSupport::FeatureSpecAssignmentSet.new(model_configuration).to_s) %>

    submit_form

    expect(page).to have_content("<%= model_configuration.as_name.titleize %> was successfully created.")
    <%= model_configuration.model_name %> = <%= model_configuration.as_constant %>.order(created_at: :desc).first
<%= render_with_indent(2, Frontier::SpecSupport::ObjectAttributesAssertion.new(model_configuration).to_s) %>
  end
end
