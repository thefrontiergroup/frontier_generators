require 'rails_helper'

feature 'Admin can sort an index of <%= model_configuration.model_name.pluralize %>' do

  sign_in_as(:admin)

<% model_configuration.attributes.select(&:sortable?).sort_by(&:name).each do |attribute| %>
<%= render_with_indent(2, Frontier::FeatureSpec::SortScenario.new(attribute).to_s) %>

<% end %>
private

<%= render_with_indent(2, Frontier::FeatureSpec::VisitIndexMethod.new(model_configuration).to_s) %>

<%= render_with_indent(2, Frontier::FeatureSpec::OrderExpectationMethod.new(model_configuration).to_s) %>

end
