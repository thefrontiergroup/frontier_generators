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

# CRUD

  alias :index?   :is_admin?
  alias :new?     :is_admin?
  alias :create?  :is_admin?
  alias :edit?    :is_admin?
  alias :update?  :is_admin?
  alias :destroy? :is_admin?

end