class <%= controller_name_and_superclass %>

<% if model_configuration.show_index? -%>
<%= render_with_indent(1, Frontier::ControllerAction::IndexAction.new(model_configuration).to_s) %>

<% end -%>
<% if model_configuration.show_create? -%>
<%= render_with_indent(1, Frontier::ControllerAction::NewAction.new(model_configuration).to_s) %>

<%= render_with_indent(1, Frontier::ControllerAction::CreateAction.new(model_configuration).to_s) %>

<% end -%>
<% if model_configuration.show_update? -%>
<%= render_with_indent(1, Frontier::ControllerAction::EditAction.new(model_configuration).to_s) %>

<%= render_with_indent(1, Frontier::ControllerAction::UpdateAction.new(model_configuration).to_s) %>

<% end -%>
<% if model_configuration.show_delete? -%>
<%= render_with_indent(1, Frontier::ControllerAction::DestroyAction.new(model_configuration).to_s) %>
<% end -%>
<% if model_configuration.show_create? || model_configuration.show_update? || model_configuration.show_delete? -%>

private

<%= render_with_indent(1, Frontier::ControllerAction::StrongParamsMethod.new(model_configuration).to_s) %>

<%= render_with_indent(1, Frontier::ControllerAction::FindMethod.new(model_configuration).to_s) %>
<% end -%>

end
