class Frontier::ControllerAction::IndexAction

  include Frontier::ModelConfigurationProperty

  def to_s
    raw = <<-STRING
def index
  #{Frontier::Authorization::Assertion.new(model_configuration, :index).to_s}
  #{model_configuration.as_ivar_collection} = #{Frontier::Authorization::Scope.new(model_configuration).to_s}.page(params[:page])
end
STRING
    raw.rstrip
  end

end
