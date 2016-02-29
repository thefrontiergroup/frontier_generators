class Frontier::ControllerAction::IndexAction

  attr_reader :model_configuration

  def initialize(model_configuration)
    @model_configuration = model_configuration
  end

  def to_s
    raw = <<-STRING
def index
  #{Frontier::Authorization::Assertion.new(model_configuration, :index).to_s}
  #{model_configuration.as_ivar_collection} = #{Frontier::Authorization::Scope.new(model_configuration).to_s}
  #{model_configuration.as_ivar_collection} = sort(#{model_configuration.as_ivar_collection}).page(params[:page])
end
STRING
    raw.rstrip
  end

end
