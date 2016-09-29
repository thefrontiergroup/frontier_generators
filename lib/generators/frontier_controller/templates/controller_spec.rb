require 'rails_helper'

describe <%= controller_name %> do

<% if model.show_index? -%>
<%= render_with_indent(1, Frontier::ControllerSpec::IndexAction.new(model).to_s) %>

<% end -%>
<% if model.show_create? -%>
<%= render_with_indent(1, Frontier::ControllerSpec::NewAction.new(model).to_s) %>

<%= render_with_indent(1, Frontier::ControllerSpec::CreateAction.new(model).to_s) %>

<% end -%>
<% if model.show_update? -%>
<%= render_with_indent(1, Frontier::ControllerSpec::EditAction.new(model).to_s) %>

<%= render_with_indent(1, Frontier::ControllerSpec::UpdateAction.new(model).to_s) %>

<% end -%>
<% if model.show_delete? -%>
<%= render_with_indent(1, Frontier::ControllerSpec::DestroyAction.new(model).to_s) %>

<% end -%>
end
