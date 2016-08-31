class Ability
  include CanCan::Ability

  def initialize user, namespace
    @user = user
    Role.all.each do |role|
      if namespace == Settings.namespace_roles.admin && @user.is_admin?
        can :manage, :all
      elsif (namespace == Settings.namespace_roles.trainer && @user.is_trainer?) ||
        user.is_trainee?
        role_permissions role
      end
    end
    can [:read, :update], User, id: @user.id
  end

  private
  def role_permissions role
    role.permissions.each do |permission|
      model_class = permission.model_class
      can permission.action.to_sym, model_class.constantize do |model|
        if model_class == "Course"
          @user.in_course? model.id
        elsif model_class == "User"
          courses = @user.user_courses.pluck :course_id
          model.in_course? courses
        else
          true
        end
      end
    end
  end
end
