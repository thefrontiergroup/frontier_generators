class Frontier::ControllerAction::DestroyAction

  include Frontier::ModelProperty

  ##
  # Renders the destroy action for a controller. EG:
  #
  # def destroy
  #   @user = find_user
  #   authorize(@user)
  #   @user.destroy
  #
  #   respond_with(@user, location: admin_users_path)
  # end
  #
  def to_s
    raw = <<-STRING
def destroy
  #{model.as_ivar_instance} = find_#{model.model_name}
  #{Frontier::Authorization::Assertion.new(model, :destroy).to_s}
  #{model.as_ivar_instance}.destroy

  respond_with(#{model.as_ivar_instance}, location: #{model.url_builder.index_path})
end
STRING
    raw.rstrip
  end

end
