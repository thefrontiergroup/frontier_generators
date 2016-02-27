class <%= controller_name_and_superclass %>

<% if model_configuration.show_index? -%>
  def index
    <%= Frontier::Authorization::Assertion.new(model_configuration, :index).to_s %>
    <%= model_configuration.as_ivar_collection %> = <%= Frontier::Authorization::Scope.new(model_configuration).to_s %>
    <%= model_configuration.as_ivar_collection %> = sort(<%= model_configuration.as_ivar_collection %>).page(params[:page])
  end

<% end -%>
<% if model_configuration.show_create? -%>
<%= render_with_indent(1, Frontier::ControllerAction::NewAction.new(model_configuration).to_s) %>

<%= render_with_indent(1, Frontier::ControllerAction::CreateAction.new(model_configuration).to_s) %>

<% end -%>
<% if model_configuration.show_update? -%>
  <%= render_with_indent(1, Frontier::ControllerAction::EditAction.new(model_configuration).to_s) %>

  def update
    <%= model_configuration.as_ivar_instance %> = find_<%= model_configuration.model_name %>
    <%= model_configuration.as_ivar_instance %>.assign_attributes(strong_params_for(<%= model_configuration.as_ivar_instance %>))
    <%= model_configuration.as_ivar_instance %>.save if <%= Frontier::Authorization::Assertion.new(model_configuration, :update).to_s %>

    respond_with(<%= model_configuration.as_ivar_instance %>, location: <%= model_configuration.url_builder.index_path %>)
  end

<% end -%>
<% if model_configuration.show_delete? -%>
  def destroy
    <%= model_configuration.as_ivar_instance %> = find_<%= model_configuration.model_name %>
    <%= Frontier::Authorization::Assertion.new(model_configuration, :destroy).to_s %>
    <%= model_configuration.as_ivar_instance %>.destroy
    respond_with(<%= model_configuration.as_ivar_instance %>, location: <%= model_configuration.url_builder.index_path %>)
  end
<% end -%>
<% if model_configuration.show_create? || model_configuration.show_update? || model_configuration.show_delete? -%>

private

  def find_<%= model_configuration.model_name %>
    <%= model_configuration.as_constant %>.find(params[:id])
  end
<% end -%>

end
