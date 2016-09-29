class Frontier::ControllerAction::IndexAction

  include Frontier::ModelProperty

  def to_s
    raw = <<-STRING
def index
  #{Frontier::Authorization::Assertion.new(model, :index).to_s}
#{Frontier::RubyRenderer.new(object_scope).render(1)}
end
STRING
    raw.rstrip
  end

private

  def sortable?
    model.attributes.any?(&:sortable?)
  end

  def object_scope
    if sortable?
      # @ransack_query = User.ransack(params[:q])
      ransack_query = "@ransack_query = #{model.as_constant}.ransack(params[:q])"

      # @users = User.all, or
      # @users = @client.users
      assignment_and_scoped_query = "#{model.as_ivar_collection} = #{scoped_object}"

      # @users = User.all.merge(@ransack_query.result), or
      # @users = @client.users.merge(@ransack_query.result)
      merged_query = "#{assignment_and_scoped_query}.merge(@ransack_query.result)"

      # The leading whitespace will allow the second line of the query to line up with the first
      #
      # @users = @client.users.merge(@ransack_query.result)
      #                       .page(params[:page])
      leading_whitespace = Array.new(assignment_and_scoped_query.length, " ").join("")
      pagination  = "#{leading_whitespace}.page(params[:page])"

      [
        ransack_query,
        merged_query,
        pagination
      ].join("\n")
    else
      "#{model.as_ivar_collection} = #{scopable_object}.page(params[:page])"
    end
  end

  def scopable_object
    Frontier::ControllerActionSupport::ScopableObject.new(model).to_s
  end

  # .merge cannot be called on a class, must be called on a scoped object
  def scoped_object
    if model.controller_prefixes.any?(&:nested_model?)
      scopable_object
    else
      "#{scopable_object}.all"
    end
  end

end
