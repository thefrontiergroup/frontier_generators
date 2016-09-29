class Frontier::ControllerSpec::MemberAction

  include Frontier::ModelProperty

protected

  def render_setup
    [subject_block, target_and_nested_models_setup].select(&:present?).join("\n")
  end

  def target_and_nested_models_setup
    Frontier::FeatureSpec::TargetObjectLetStatement.new(model).to_s
  end

end
