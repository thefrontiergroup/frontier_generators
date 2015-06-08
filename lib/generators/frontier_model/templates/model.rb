class <%= model_configuration.as_constant %> < ActiveRecord::Base

  # Soft delete - uses deleted_at field
  acts_as_paranoid

<% # The whitespace here is very important, we only want to include a blank line if there are some enums, etc -%>
<% if model_configuration.attributes.select(&:is_enum?).any? -%>
<% model_configuration.attributes.select(&:is_enum?).each do |attribute| -%>
  <%= attribute.as_enum %>
<% end -%>

<% end -%>
<% if model_configuration.attributes.select(&:is_association?).any? -%>
<% model_configuration.attributes.select(&:is_association?).each do |attribute| -%>
  <%= attribute.association_implementation %>
<% end -%>

<% end -%>
<% if model_configuration.attributes.select(&:validation_required?).any? -%>
<% model_configuration.attributes.select(&:validation_required?).each do |attribute| -%>
  <%= attribute.validation_implementation %>
<% end -%>

<% end -%>
  def to_s
    <%= model_configuration.primary_attribute.name %>
  end

end