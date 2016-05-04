class Frontier::ControllerAction::IndexAction

  include Frontier::ModelConfigurationProperty

  def to_s
    raw = <<-STRING
def index
  #{Frontier::Authorization::Assertion.new(model_configuration, :index).to_s}
#{Frontier::RubyRenderer.new(object_scope).render(1)}
end
STRING
    raw.rstrip
  end

private

  def sortable?
    model_configuration.attributes.any?(&:sortable?)
  end

  def object_scope
    if sortable?
      ransack_query = "@ransack_query = #{model_configuration.as_constant}.ransack(params[:q])"
      assignment_and_scoped_query = "#{model_configuration.as_ivar_collection} = #{scopable_object}"
      merged_query = "#{assignment_and_scoped_query}.merge(@ransack_query.result)"

      # The leading whitespace will allow the second line of the query to line up with the first
      leading_whitespace = Array.new(assignment_and_scoped_query.length, " ").join("")
      pagination  = "#{leading_whitespace}.page(params[:page])"

      [
        ransack_query,
        merged_query,
        pagination
      ].join("\n")
    else
      "#{model_configuration.as_ivar_collection} = #{scopable_object}.page(params[:page])"
    end
  end

  def scopable_object
    Frontier::ControllerActionSupport::ScopableObject.new(model_configuration).to_s
  end

end
