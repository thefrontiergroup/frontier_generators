class <%= model_configuration.as_constant %> < ActiveRecord::Base

  # Soft delete - uses deleted_at field
  acts_as_paranoid

<% model_configuration.attributes.select(&:validation_required?).each do |attribute| -%>
  <%= attribute.validation_implementation %>
<% end -%>

end

