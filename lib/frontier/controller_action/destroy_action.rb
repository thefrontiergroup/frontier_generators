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
  #{model.name.as_singular_ivar} = find_#{model.name.as_singular}
  #{Frontier::Authorization::Assertion.new(model, :destroy).to_s}
  #{model.name.as_singular_ivar}.destroy

  respond_with(#{model.name.as_singular_ivar}, location: #{model.url_builder.index_path})
end
STRING
    raw.rstrip
  end

end
