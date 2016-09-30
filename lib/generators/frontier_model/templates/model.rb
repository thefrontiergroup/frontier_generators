class <%= model.name.as_constant %> < ActiveRecord::Base

<% if model.soft_delete -%>
  # Soft delete - uses deleted_at field
  acts_as_paranoid

<% end -%>
<% # The whitespace here is very important, we only want to include a blank line if there are some enums, etc -%>
<% if model.attributes.flat_map(&:constants).any? -%>
<% model.attributes.sort_by(&:name).flat_map(&:constants).each do |constant| -%>
  <%= constant.model_implementation %>
<% end -%>

<% end -%>
<% if model.attributes.select(&:is_enum?).any? -%>
<% model.attributes.sort_by(&:name).select(&:is_enum?).each do |attribute| -%>
  <%= attribute.as_enum %>
<% end -%>

<% end -%>
<% if model.attributes.select(&:is_association?).any? -%>
<% model.attributes.sort_by(&:name).select(&:is_association?).each do |association| -%>
<%= render_with_indent(1, Frontier::Association::ModelImplementation.new(association).to_s) %>
<% end -%>

<% end -%>
<% if model.attributes.select(&:validation_required?).any? -%>
<% model.attributes.sort_by(&:name).select(&:validation_required?).each do |attribute| -%>
  <%= attribute.validation_implementation %>
<% end -%>

<% end -%>
  def to_s
    <%= model.primary_attribute.name %>
  end

end
