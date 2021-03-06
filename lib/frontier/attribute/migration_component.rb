require_relative '../attribute'

class Frontier::Attribute::MigrationComponent

  attr_reader :attribute

  def initialize(attribute)
    @attribute = attribute
  end

  def to_s
    [attribute.name, migration_type, index_component].compact.join(":")
  end

private

  # Can be 'uniq' or 'index'
  def index_component
     if requires_index?
      # If index is a string (EG: "uniq"), pass that through
      if attribute.properties[:index].is_a?(String)
        attribute.properties[:index]
      # If no index is specified or a boolean is used, it should just be a regular index
      else
        "index"
      end
    end
  end

  def migration_type
    case attribute.properties[:type]
    when "enum"
      "integer"
    else
      attribute.properties[:type]
    end
  end

  def requires_index?
    attribute.properties[:index] || attribute.properties[:searchable] || attribute.properties[:sortable]
  end

end
