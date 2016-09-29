require 'rails_helper'

feature 'Admin can delete an existing <%= model.as_constant %>' do

  sign_in_as(:admin)
<%= render_with_indent(1, Frontier::FeatureSpec::TargetObjectLetStatement.new(model).to_s) %>

  before do
    visit(<%= model.url_builder.index_path(show_nested_model_as_ivar: false) %>)
  end

  scenario do
    within_row(<%= model.model_name %>.<%= model.primary_attribute.name %>) do
      click_link("Delete")
    end

    expect(page).to have_flash(:notice)
    expect(page).not_to have_content(<%= model.model_name %>.<%= model.primary_attribute.name %>)
    # Ensure object is deleted
    expect(<%= model.model_name %>.reload).to be_deleted
  end
end
