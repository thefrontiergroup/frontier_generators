class Frontier::FactoryGirlSupport::Declaration

  attr_reader :model_configuration_or_association, :verb

  def initialize(verb, model_configuration_or_association)
    @verb = verb
    @model_configuration_or_association = model_configuration_or_association
  end

  def to_s
    "FactoryGirl.#{verb}(:#{class_name})"
  end

private

  def class_name
    if model_configuration_or_association.is_a?(Frontier::ModelConfiguration)
      model_configuration_or_association.model_name
    elsif model_configuration_or_association.is_a?(Frontier::Association)
      model_configuration_or_association.association_class.underscore
    end
  end

end
