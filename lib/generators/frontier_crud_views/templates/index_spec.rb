require 'rails_helper'

feature 'Admin can view an index of <%= model_configuration.model_name.pluralize %>' do

  sign_in_as(:admin)
  let!(<%= model_configuration.as_symbol %>) { FactoryGirl.create(<%= model_configuration.as_symbol %>) }

  before do
    visit(<%= model_configuration.url_builder.index_path %>)
  end

  scenario "Admin can see <%= model_configuration.model_name.pluralize %>" do
    within("table") do
      expect(page).to have_content(<%= model_configuration.model_name %>.<%= model_configuration.primary_attribute.name %>)
    end
  end

end