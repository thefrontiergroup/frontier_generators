require_relative "../../frontier"

class FrontierCrudViewsGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  def scaffold
    unless model.skip_ui?
      [
        [model.view_paths.index_path || "index.html.haml", model.show_index?],
        [model.view_paths.form_path || "_form.html.haml", model.show_create? || model.show_update?],
        [model.view_paths.new_path || "new.html.haml", model.show_create?],
        [model.view_paths.edit_path || "edit.html.haml", model.show_update?]
      ].each do |template_filename, should_generate|
        if should_generate
          template template_filename, File.join(Frontier::Views::ViewsFolderPath.new(model).to_s, template_filename)
        end
      end

      generate_feature_path("index_spec.rb", "#{model.name.as_plural}_index_spec.rb") if model.show_index?
      generate_feature_path("delete_spec.rb", "delete_#{model.name.as_singular}_spec.rb") if model.show_delete?
      generate_feature_path("create_spec.rb", "create_#{model.name.as_singular}_spec.rb") if model.show_create?
      generate_feature_path("update_spec.rb", "update_#{model.name.as_singular}_spec.rb") if model.show_update?

      if model.attributes.any?(&:sortable?)
        generate_feature_path("sort_index_spec.rb", "#{model.name.as_plural}_sort_index_spec.rb") if model.show_index?
      end
    end
  end

private

  def instance_actions
    @instance_actions ||= Frontier::Views::Index::InstanceActions.new(model)
  end

  def generate_feature_path(template_name, feature_name)
    feature_path = File.join(Frontier::Views::FeatureSpecPath.new(model).to_s, feature_name)
    template(template_name, feature_path)
  end

end
