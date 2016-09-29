class Frontier::MigrationStringBuilder

  include Frontier::ModelProperty

  # EG: CreateDriver name:string contact_number:string
  def to_s
    "Create#{model.as_constant} #{extra_columns}"
  end

private

  # Should be in the format attribute_name:type attribute_name:type
  # EG: name:string date_of_birth:datetime
  def model_attributes
    model.attributes.collect(&:as_migration_component)
  end

  def extra_columns
    default_columns = ["created_at:datetime", "updated_at:datetime"]
    default_columns << "deleted_at:datetime:index" if model.soft_delete
    (model_attributes + default_columns).join(" ")
  end
end
