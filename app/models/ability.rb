class Ability
  include CanCan::Ability

  def initialize user
    if user.is_admin?
      can :manage, :all
    else
      user.role.permissions.each do |permission|
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

      can [:read, :update], User, id: user.id
    end
  end
end
