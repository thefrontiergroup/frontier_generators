require_relative "./lib/model_configuration"

class TfgScaffoldGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  attr_accessor :model_configuration

  # What do we scaffold:
  #
  #   * Migration (Include deleted_at for soft delete)
  #   * Build model (with unit tests)
  #   * Build factories with limited support for FFaker
  #   * Build controller (with unit tests)
  #   * Build routes
  #   * Build views (_form, edit, index, new)
  #   * Build policy objects (with unit tests)
  #
  def scaffold
    self.model_configuration = ModelConfiguration.new(ARGV[0])

    puts "Namespaces: #{model_configuration.namespaces}"
    puts "Model Name: #{model_configuration.model_name}"
    puts "Attributes: #{model_configuration.attributes}"

    # Generate models
    generate("tfg_model", ARGV[0])

    # Generate controllers
    generate("tfg_controller", ARGV[0])

    # Generate views
    generate("tfg_crud_views", ARGV[0])

    # Generate policies
    generate("tfg_policy", ARGV[0])

    # Generate routes
    generate("tfg_route", ARGV[0])

    # Version 1
    #
    # Build features (create, index, update, destroy using soft-delete)
    #
    # Version 2
    #
    # Ordering by column (Order object, feature specs)
    # Searching (nominate searchable fields. Support strings, booleans, and enums out of the box)
    # Export as CSV (Have a default CSVExport object that accepts some symbols of keys and exports)
    #   This will probably require two steps - 1. Choose fields to export, 2. Export those as CSV
    #
    # Version 3
    #
    # Add in model validations
  end

end
