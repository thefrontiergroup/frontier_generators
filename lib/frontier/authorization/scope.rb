class Frontier::Authorization::Scope

  include Frontier::ModelConfigurationProperty

  def to_s
    if model_configuration.using_pundit?
      # policy_scope(User.all)
      "policy_scope(#{model_configuration.as_constant}.all)"
    else
      # For now, do not apply any scope to the collection
      # User.all
      "#{model_configuration.as_constant}.all"
    end
  end

end
