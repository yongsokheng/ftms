class Ability
  include CanCan::Ability

  def initialize user, namespace
    if namespace.to_s == Settings.namespace_roles.admin && user.is_admin?
      can :manage, :all
    elsif namespace.to_s == Settings.namespace_roles.trainer && user.is_trainer?
      role_permissions 2
    elsif user.is_trainee?
      role_permissions 3
    end
    can [:read, :update], User, id: user.id
  end

  private
  def role_permissions role_id
    role = Role.find_by_id role_id

    role.permissions.each do |permission|
      model_class = permission.model_class
      can permission.action.to_sym, model_class.constantize do |model|
        if model_class == "Course"
          user.in_course? model.id
        elsif model_class == "User"
          courses = user.user_courses.pluck :course_id
          model.in_course? courses
        else
          true
        end
      end
    end
  end
end
