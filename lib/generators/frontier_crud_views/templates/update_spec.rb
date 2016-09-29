require 'rails_helper'

feature 'Admin can update an existing <%= model.name.as_constant %>' do

  sign_in_as(:admin)
<%= render_with_indent(1, Frontier::FeatureSpec::TargetObjectLetStatement.new(model).to_s) %>
<%= render_with_indent(1, Frontier::Spec::ObjectSetup::AttributesSetup.new(model).to_s) %>
<%= render_with_indent(1, Frontier::Spec::ObjectSetup::AssociatedModelSetup.new(model).to_s) %>

  before do
    visit(<%= model.url_builder.index_path(show_nested_model_as_ivar: false) %>)
    within_row(<%= model.name.as_singular %>.<%= model.primary_attribute.name %>) do
      click_link("Edit")
    end
  end

  scenario 'with valid data' do
<%= render_with_indent(2, Frontier::Spec::FeatureSpecAssignmentSet.new(model).to_s) %>

    submit_form

    expect(page).to have_content("<%= model.name.as_singular_with_spaces.capitalize %> was successfully updated.")
    <%= model.name.as_singular %>.reload
<%= render_with_indent(2, Frontier::Spec::ObjectAttributesAssertion.new(model).to_s) %>
  end

end
