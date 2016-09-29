require 'rails_helper'

feature 'Admin can create a new <%= model.as_constant %>' do

  sign_in_as(:admin)
<%= render_with_indent(1, Frontier::Spec::NestedModelLetSetup.new(model).to_s) %>
<%= render_with_indent(1, Frontier::Spec::ObjectSetup::AttributesSetup.new(model).to_s) %>
<%= render_with_indent(1, Frontier::Spec::ObjectSetup::AssociatedModelSetup.new(model).to_s) %>

  before do
    visit(<%= model.url_builder.index_path(show_nested_model_as_ivar: false) %>)
    click_link("Add <%= model.as_name.with_indefinite_article %>")
  end

  scenario 'with valid data' do
<%= render_with_indent(2, Frontier::Spec::FeatureSpecAssignmentSet.new(model).to_s) %>

    submit_form

    expect(page).to have_content("<%= model.as_name.capitalize %> was successfully created.")
    <%= model.model_name %> = <%= model.as_constant %>.order(created_at: :desc).first
<%= render_with_indent(2, Frontier::Spec::ObjectAttributesAssertion.new(model).to_s) %>
  end
end
