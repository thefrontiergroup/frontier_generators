class MigrationStringBuilder
  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  # EG: CreateDriver name:string contact_number:string
  def to_s
    "Create#{model_configuration.as_constant} #{extra_columns}"
  end

private

  # Should be in the format attribute_name:type attribute_name:type
  # EG: name:string date_of_birth:datetime
  def model_attributes
    model_configuration.attributes.collect(&:as_migration_component)
  end

  def extra_columns
    default_columns = ["created_at:datetime", "updated_at:datetime"]
    default_columns << "deleted_at:datetime:index" if model_configuration.soft_delete
    (model_attributes + default_columns).join(" ")
  end
end