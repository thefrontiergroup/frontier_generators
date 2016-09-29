require 'rails_helper'

describe <%= model.name.as_constant %> do
<% model.attributes.sort_by(&:name).select(&:validation_required?).each do |attribute| -%>

  describe "@<%= attribute.name %>" do
<% attribute.validations.each do |validation| -%>
<%= render_with_indent(2, validation.as_spec) %>
<% end -%>
  end
<% end -%>

  describe "#to_s" do
    subject { <%= model.name.as_constant %>.new(<%= model.primary_attribute.name %>: "Name").to_s }
    it { should eq("Name") }
  end

end
