require_relative "../../model_configuration/model_configuration"

class FrontierPolicyGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  attr_accessor :model_configuration

  def scaffold
    self.model_configuration = ModelConfiguration::YamlParser.new(ARGV[0]).model_configuration

    unless model_configuration.skip_ui? || model_configuration.skip_policies?
      template "policy.rb", policy_path
      template "policy_spec.rb", policy_spec_path
    end
  end

# Scaffold methods - called from within template

  def policy_class_name
    "#{model_configuration.as_constant}Policy"
  end

private

  def policy_path
    template_filename = "#{model_configuration.model_name}_policy.rb"
    File.join("app", "policies", template_filename)
  end

  def policy_spec_path
    template_filename = "#{model_configuration.model_name}_policy_spec.rb"
    File.join("spec", "policies", template_filename)
  end

end
