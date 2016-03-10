class Frontier::Association::ModelImplementation

  attr_reader :association

  def initialize(association)
    @association = association
  end

  def to_s
    [
      association_declaration,
      (nested_declaration if association.is_nested?)
    ].compact.join("\n")
  end

private

  def association_declaration
    [implementation_without_options, implementation_options].compact.join(", ")
  end

  def class_name
    association.properties[:class_name]
  end

  def implementation_without_options
    case association.properties[:type]
    when "belongs_to"
      "belongs_to #{association.as_symbol}"
    when "has_one"
      "has_one #{association.as_symbol}"
    when "has_many"
      "has_many #{association.as_symbol}"
    when "has_and_belongs_to_many"
      "has_and_belongs_to_many #{association.as_symbol}"
    end
  end

  def implementation_options
    options = nil
    if class_name.present?
      options = "class_name: #{class_name}"
    end
    options
  end

  def nested_declaration
    "accepts_nested_attributes_for #{association.as_symbol}"
  end

end
