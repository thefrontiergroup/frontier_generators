class <%= model_configuration.as_constant %> < ActiveRecord::Base

  # Soft delete - uses deleted_at field
  acts_as_paranoid

<% model_configuration.attributes.select(&:validation_required?).each do |attribute| -%>
<% model_configuration.attributes.validations.each do |validation| -%>
  <%= validation.implementation %>
<% end -%>
<% end -%>

  def to_s
    <%= model_configuration.primary_attribute.name %>
  end

end