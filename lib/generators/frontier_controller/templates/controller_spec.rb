require 'rails_helper'

describe <%= controller_name %> do

<% if model_configuration.show_index? -%>
<%= render_with_indent(1, Frontier::ControllerSpec::IndexAction.new(model_configuration).to_s) %>

<% end -%>
<% if model_configuration.show_create? -%>
<%= render_with_indent(1, Frontier::ControllerSpec::NewAction.new(model_configuration).to_s) %>

<%= render_with_indent(1, Frontier::ControllerSpec::CreateAction.new(model_configuration).to_s) %>

<% end -%>
<% if model_configuration.show_update? -%>
<%= render_with_indent(1, Frontier::ControllerSpec::EditAction.new(model_configuration).to_s) %>

<%= render_with_indent(1, Frontier::ControllerSpec::UpdateAction.new(model_configuration).to_s) %>

<% end -%>
<% if model_configuration.show_delete? -%>
<%= render_with_indent(1, Frontier::ControllerSpec::DestroyAction.new(model_configuration).to_s) %>

<% end -%>
end
