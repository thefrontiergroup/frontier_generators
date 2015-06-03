class <%= model_configuration.as_constant %> < ActiveRecord::Base

  # Soft delete - uses deleted_at field
  acts_as_paranoid

<% model_configuration.attributes.select(&:is_association?).each do |attribute| -%>
  <%= attribute.association_implementation %>
<% end -%>

<% model_configuration.attributes.select(&:validation_required?).each do |attribute| -%>
  <%= attribute.validation_implementation %>
<% end -%>

  def to_s
    <%= model_configuration.primary_attribute.name %>
  end

end