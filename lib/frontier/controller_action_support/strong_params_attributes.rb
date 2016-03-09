class Frontier::ControllerActionSupport::StrongParamsAttributes

  # EG: Frontier::ModelConfiguration or Frontier::Association
  attr_reader :object_with_attributes

  def initialize(object_with_attributes)
    @object_with_attributes = object_with_attributes
  end

  def count
    strong_params_count(to_array)
  end

  # Returns an array of strong params
  #
  # EG: [:id, :name, :email]                      # with attributes
  # EG: [:id, :name, :email, :address_id]         # with association
  # EG: [:id, {address_attributes: [:id, :name]}] # with nested association
  def to_array
    object_with_attributes.attributes
                          .sort_by(&:name)
                          .collect(&method(:object_as_strong_params))
  end

private

  # EG: :name
  def attribute_as_strong_params(attribute)
    attribute.name.to_sym
  end

  def association_as_strong_params(association)
    if association.is_nested?
      # EG: user_attributes: [:id, :name, :email]
      key = (association.name + "_attributes").to_sym
      {key => self.class.new(association).to_array}
    else
      # EG: :user_id
      (association.name + "_id").to_sym
    end
  end

  def object_as_strong_params(attribute_or_association)
    if attribute_or_association.is_attribute?
      attribute_as_strong_params(attribute_or_association)
    else
      association_as_strong_params(attribute_or_association)
    end
  end

  def strong_params_count(strong_params_array)
    attributes_count = strong_params_array.map do |param|
      if param.is_a?(Hash)
        strong_params_count(param.values.flatten)
      else
        1
      end
    end
    attributes_count.inject {|total, i| total += i}
  end

end
