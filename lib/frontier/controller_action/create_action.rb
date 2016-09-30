class Frontier::ControllerAction::CreateAction

  include Frontier::ModelProperty

  ##
  # Renders the create action for a controller. EG:
  #
  # def create
  #   @user = User.new(strong_params_for(User))
  #   @user.save if authorize(@user)
  #
  #   respond_with(@user, location: admin_users_path)
  # end
  #
  def to_s
    raw = <<-STRING
def create
  #{model.name.as_singular_ivar} = #{scopable_object}.new(strong_params_for_#{model.name.as_singular})
  #{Frontier::Authorization::Assertion.new(model, :create).to_s}
  #{model.name.as_singular_ivar}.save

  respond_with(#{model.name.as_singular_ivar}, location: #{model.url_builder.index_path})
end
STRING
    raw.rstrip
  end

private

  def scopable_object
    Frontier::ControllerActionSupport::ScopableObject.new(model).to_s
  end

end
