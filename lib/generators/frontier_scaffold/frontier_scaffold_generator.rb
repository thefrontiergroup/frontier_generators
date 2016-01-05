require_relative "../../frontier"

class FrontierScaffoldGenerator < Frontier::Generator
  source_root File.expand_path('../templates', __FILE__)

  # What we scaffold:
  #
  #   * Build model (with unit tests)
  #   * Migration (Include deleted_at for soft delete)
  #   * Build factories with limited support for FFaker
  #   * Build controller (with unit tests)
  #   * Build routes
  #   * Build views (_form, edit, index, new)
  #   * Build policy objects (with unit tests)
  #   * Build feature tests (index, create, update, destroy with soft-delete)
  #
  def scaffold
    # Generate models
    generate("frontier_model", ARGV[0])

    unless model_configuration.skip_ui?
      # Generate controllers
      generate("frontier_controller", ARGV[0])

      # Generate views
      generate("frontier_crud_views", ARGV[0])

      # Generate policies
      generate("frontier_policy", ARGV[0])

      # Generate routes
      generate("frontier_route", ARGV[0])
    end

    # Version 2
    #
    # 1. Add in model validations
    # 2. Searching (nominate searchable fields. Support strings, booleans, and enums out of the box)
    # 3. Export as CSV (Have a default CSVExport object that accepts some symbols of keys and exports)
    #      This will probably require two steps - 1. Choose fields to export, 2. Export those as CSV
  end

end
