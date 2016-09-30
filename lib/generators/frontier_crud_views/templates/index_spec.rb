require 'rails_helper'

feature 'Admin can view an index of <%= model.name.as_constant.pluralize %>' do

  sign_in_as(:admin)
<%= render_with_indent(1, Frontier::FeatureSpec::TargetObjectLetStatement.new(model).to_s) %>

  before do
    visit(<%= model.url_builder.index_path(show_nested_model_as_ivar: false) %>)
  end

  scenario do
    within("table") do
      expect(page).to have_content(<%= model.name.as_singular %>.<%= model.primary_attribute.name %>)
    end
  end

end
