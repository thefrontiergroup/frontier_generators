require 'rails_helper'

feature 'Admin can delete an existing <%= model.name.as_constant %>' do

  sign_in_as(:admin)
<%= render_with_indent(1, Frontier::FeatureSpec::TargetObjectLetStatement.new(model).to_s) %>

  before do
    visit(<%= model.url_builder.index_path(show_nested_model_as_ivar: false) %>)
  end

  scenario do
    within_row(<%= model.name.as_singular %>.<%= model.primary_attribute.name %>) do
      click_link("Delete")
    end

    expect(page).to have_flash(:notice, "<%= model.name.as_singular_with_spaces.capitalize %> was successfully archived.")
    expect(page).not_to have_content(<%= model.name.as_singular %>.<%= model.primary_attribute.name %>)
    # Ensure object is deleted
<% if model.soft_delete -%>
    expect(<%= model.name.as_singular %>.reload).to be_deleted
<% else -%>
    expect(<%= model.name.as_constant %>.count).to eq(0)
<% end -%>
  end
end
