class Frontier::FactoryGirlSupport::Declaration

  attr_reader :factory_object, :verb

  def initialize(verb, factory_object)
    @verb = verb
    @factory_object = factory_object
  end

  def to_s
    "FactoryGirl.#{verb}(:#{class_name})"
  end

private

  def class_name
    case factory_object
    when Frontier::ModelConfiguration
      factory_object.model_name
    when Frontier::Association
      factory_object.association_class.underscore
    else
      factory_object
    end
  end

end
