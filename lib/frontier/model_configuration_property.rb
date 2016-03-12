module Frontier::ModelConfigurationProperty

  include Frontier::IndentRenderer

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

end
