require 'rails_helper'

feature 'Admin can update an existing <%= model_configuration.as_constant %>' do

  sign_in_as(:admin)
  <%= Frontier::SpecSupport::LetStatement.new(model_configuration.model_name, Frontier::FactoryGirlSupport::Declaration.new("create", model_configuration).to_s).to_s(has_bang: true) %>
<%= render_with_indent(1, Frontier::SpecSupport::ObjectSetup::AttributesSetup.new(model_configuration).to_s) %>
<%= render_with_indent(1, Frontier::SpecSupport::ObjectSetup::AssociatedModelSetup.new(model_configuration).to_s) %>

  before do
    visit(<%= model_configuration.url_builder.index_path %>)
    within_row(<%= model_configuration.model_name %>.<%= model_configuration.primary_attribute.name %>) do
      click_link("Edit")
    end
  end

  scenario 'Admin updates user with valid data' do
<%= render_with_indent(2, Frontier::SpecSupport::FeatureSpecAssignmentSet.new(model_configuration).to_s) %>

    submit_form

    <%= model_configuration.model_name %>.reload
<%= render_with_indent(2, Frontier::SpecSupport::ObjectAttributesAssertion.new(model_configuration).to_s) %>
  end

end
