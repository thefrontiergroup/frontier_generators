class Frontier::Association::FactoryDeclaration

  attr_reader :association

  def initialize(association)
    @association = association
  end

  def to_s
    if (class_name = association.properties[:class_name]).present?
      # association :delivery_address, factory: :address
      "association #{association.as_symbol}, factory: :#{class_name.underscore}"
    else
      # association :address
      "association #{association.as_symbol}"
    end
  end

end
