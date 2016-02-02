require 'rails_helper'

describe <%= model_configuration.as_constant %> do
<% model_configuration.attributes.select(&:validation_required?).each do |attribute| -%>

  describe "@<%= attribute.name %>" do
<% attribute.validations.each do |validation| -%>
<% case validation.key -%>
<% when "uniqueness" -%>
    describe "validating uniquess" do
      subject { FactoryGirl.create(<%= model_configuration.as_symbol %>) }
      it { should validate_uniqueness_of(<%= attribute.as_symbol %>) }
    end
<% else -%>
    <%= validation.as_spec %>
<% end -%>
<% end -%>
  end
<% end -%>

  describe "#to_s" do
    subject { <%= model_configuration.as_constant %>.new(<%= model_configuration.primary_attribute.name %>: "Name").to_s }
    it { should eq("Name") }
  end

end
