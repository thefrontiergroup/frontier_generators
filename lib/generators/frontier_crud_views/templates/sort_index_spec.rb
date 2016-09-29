require 'rails_helper'

feature 'Admin can sort an index of <%= model.name.as_plural %>' do

  sign_in_as(:admin)

<% model.attributes.select(&:sortable?).sort_by(&:name).each do |attribute| -%>
<%= render_with_indent(1, Frontier::FeatureSpec::SortScenario.new(attribute).to_s) %>

<% end -%>
private

<%= render_with_indent(1, Frontier::FeatureSpec::VisitIndexMethod.new(model).to_s) %>

<%= render_with_indent(1, Frontier::FeatureSpec::OrderExpectationMethod.new(model).to_s) %>

end
