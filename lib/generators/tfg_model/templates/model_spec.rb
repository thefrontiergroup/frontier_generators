require 'spec_helper'

describe <%= model_configuration.as_constant %> do

<% model_configuration.attributes.select(&:validation_required?).each do |attribute| -%>
  describe "@<%= attribute.name %>" do
    <%= attribute.validation_spec %>
  end

<% end -%>

end