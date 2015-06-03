class <%= policy_class_name %> < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.present? && (user.admin? || user.member?)
        scope
      else
        scope.none
      end
    end
  end

  def permitted_attributes
    if is_admin? || is_member?
      [<%= model_configuration.attributes.map(&:as_symbol).join(", ") %>]
    else
      []
    end
  end

end