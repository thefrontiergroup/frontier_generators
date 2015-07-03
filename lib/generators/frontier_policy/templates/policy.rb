class <%= policy_class_name %> < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
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
      [<%= model_configuration.attributes.map(&:as_field_name).join(", ") %>]
    else
      []
    end
  end

end