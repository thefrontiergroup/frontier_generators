class Frontier::Association::FactoryDeclaration

  attr_reader :association

  def initialize(association)
    @association = association
  end

  ##
  # We use the :build strategy by default. Otherwise FG will persist the association
  # even when we FactoryGirl.build the parent object.
  #
  # This is almost always problematic. Why persist children if we don't necessarily
  # want to persist the parent? EG: In a spec where we are trying to avoid
  # hitting the DB for performance reasons.
  #
  # If we build the associations, they will be persisted when we save the parent
  # object anyway.
  #
  def to_s
    if (class_name = association.properties[:class_name]).present?
      # association :delivery_address, strategy: :build, factory: :address
      "#{base_association_declaration}, strategy: :build, factory: :#{class_name.underscore}"
    else
      # association :address, strategy: :build
      "#{base_association_declaration}, strategy: :build"
    end
  end

private

  def base_association_declaration
    "association #{association.as_symbol}"
  end

end
