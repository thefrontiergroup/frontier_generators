class Frontier::Model::ViewPaths

  attr_reader :index_path, :new_path, :edit_path, :form_path

  # view_path_attributes will be a hash that might be nil, or have the following:
  # {
  #   index: "config/frontier_generators/views/index.html.haml",
  #   new: "config/frontier_generators/views/new.html.haml",
  #   edit: "config/frontier_generators/views/edit.html.haml",
  #   form: "config/frontier_generators/views/form_.html.haml"
  # }
  def initialize(view_path_attributes)
    if !view_path_attributes.nil?
      @index_path = view_path_attributes[:index]
      @new_path   = view_path_attributes[:new]
      @edit_path  = view_path_attributes[:edit]
      @form_path  = view_path_attributes[:form]

      verify_paths_exist!
    end
  end

private

  def path_doesnt_exist?(path)
    !path.nil? && !File.exist?(path)
  end

  def verify_paths_exist!
    failed_paths = []

    failed_paths << ["index"] if path_doesnt_exist?(index_path)
    failed_paths << ["new"]   if path_doesnt_exist?(new_path)
    failed_paths << ["edit"]  if path_doesnt_exist?(edit_path)
    failed_paths << ["form"]  if path_doesnt_exist?(form_path)

    if failed_paths.any?
      error_message = "The following templates do not exist: " + failed_paths.join(", ")
      raise(ArgumentError, error_message)
    end
  end

end
