class Frontier::Views::Index::InstanceActions

  include Frontier::ModelConfigurationProperty

  def has_actions?
    model_configuration.show_update? || model_configuration.show_delete?
  end

  ##
  # Render the actions that will be visible on the index page for a given
  # model. EG:
  #
  # - if can?(:edit, user)
  #   = link_to "Edit", edit_admin_user_path(user), class: "btn btn-small"
  # - if can?(:destroy, user)
  #   = link_to "Delete", admin_user_path(user), method: :delete, data: {confirm: "Are you sure you want to delete this user?"}, class: "btn btn-small btn-danger"
  #
  def to_s
    loc = []
    if model_configuration.show_update?
      loc << render_authorization(:edit)
      loc << render_with_indent(1, edit_link_to)
    end
    if model_configuration.show_delete?
      loc << render_authorization(:destroy)
      loc << render_with_indent(1, delete_link_to)
    end

    loc.join("\n")
  end

private

  def edit_link_to
    render_link_to(
      '"Edit"',
      model_configuration.url_builder.edit_path,
      {class: "btn btn-small"}
    )
  end

  def delete_link_to
    render_link_to(
      '"Delete"',
      model_configuration.url_builder.delete_path,
      {
        method: :delete,
        data: {confirm: "Are you sure you want to delete this #{model_configuration.as_title.downcase}?"},
        class: "btn btn-small btn-danger"
      }
    )
  end

  def render_authorization(action)
    "- if #{Frontier::Authorization::Check.new(model_configuration, model_configuration.model_name, action)}"
  end

  def render_link_to(name, path, options)
    "= link_to(#{name}, #{path}, #{Frontier::HashSingleLineDecorator.new(options).to_s})"
  end

end
