require 'spec_helper'

describe <%= model_configuration.as_constant %> do

<% model_configuration.attributes.select(&:validation_required?).each do |attribute| -%>
  describe "@<%= attribute.name %>" do
<% model_configuration.attributes.validations.each do |validation| -%>
    <%= validation.spec %>
<% end -%>
  end
<% end -%>

  describe "#to_s" do
    subject { <%= model_configuration.as_constant %>.new(<%= model_configuration.primary_attribute.name %>: "Name").to_s }
    it { should eq("Name") }
  end

end