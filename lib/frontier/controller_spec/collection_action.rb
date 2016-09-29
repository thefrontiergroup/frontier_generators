class Frontier::ControllerSpec::CollectionAction

  include Frontier::ModelProperty

protected

  def render_setup
    [subject_block, nested_models_setup].select(&:present?).join("\n")
  end

  def nested_models_setup
    Frontier::Spec::NestedModelLetSetup.new(model).to_s
  end

end
