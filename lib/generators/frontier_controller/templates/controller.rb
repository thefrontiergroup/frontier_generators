class <%= controller_name_and_superclass %>

<% if model_configuration.show_index? -%>
  def index
    <%= Frontier::Controller::AuthorizeStatement.new(model_configuration, :index).to_s %>
    <%= model_configuration.as_ivar_collection %> = sort(policy_scope(<%= model_configuration.as_constant %>.all)).page(params[:page])
  end

<% end -%>
<% if model_configuration.show_create? -%>
  def new
    <%= model_configuration.as_ivar_instance %> = <%= model_configuration.as_constant %>.new
    <%= Frontier::Controller::AuthorizeStatement.new(model_configuration, :new).to_s %>
  end

  def create
    <%= model_configuration.as_ivar_instance %> = <%= model_configuration.as_constant %>.new(strong_params_for(<%= model_configuration.as_constant %>))
    <%= model_configuration.as_ivar_instance %>.save if <%= Frontier::Controller::AuthorizeStatement.new(model_configuration, :create).to_s %>

    respond_with(<%= model_configuration.as_ivar_instance %>, location: <%= model_configuration.url_builder.index_path %>)
  end

<% end -%>
<% if model_configuration.show_update? -%>
  def edit
    <%= model_configuration.as_ivar_instance %> = find_<%= model_configuration.model_name %>
    <%= Frontier::Controller::AuthorizeStatement.new(model_configuration, :edit).to_s %>
  end

  def update
    <%= model_configuration.as_ivar_instance %> = find_<%= model_configuration.model_name %>
    <%= model_configuration.as_ivar_instance %>.assign_attributes(strong_params_for(<%= model_configuration.as_ivar_instance %>))
    <%= model_configuration.as_ivar_instance %>.save if <%= Frontier::Controller::AuthorizeStatement.new(model_configuration, :update).to_s %>

    respond_with(<%= model_configuration.as_ivar_instance %>, location: <%= model_configuration.url_builder.index_path %>)
  end

<% end -%>
<% if model_configuration.show_delete? -%>
  def destroy
    <%= model_configuration.as_ivar_instance %> = find_<%= model_configuration.model_name %>
    <%= Frontier::Controller::AuthorizeStatement.new(model_configuration, :destroy).to_s %>
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
