module RailsAdmin
  module Config
    module Actions
      class AddSubjectsToCourse < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :visible? do
          false
        end

        register_instance_option :member do
          true
        end

        register_instance_option :link_icon do
          "icon-plus"
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :pjax? do
          false
        end

        register_instance_option :action_name do
          custom_key.to_sym
        end

        register_instance_option :route_fragment do
          custom_key.to_s
        end

        register_instance_option :controller do
          proc do
            if request.post?
              course_subjects_ids = object.subjects.pluck :id
              subject_params_ids = params[:course][:subject_ids].map(&:to_i)
                .reject{|id| id == 0}

              subject_removed_ids = course_subjects_ids - subject_params_ids
              subject_add_ids = subject_params_ids - course_subjects_ids

              subject_add_ids.each do |id|
                object.course_subjects.create subject_id: id
              end

              subject_removed_ids.each do |id|
                course_subject = CourseSubject.find_by subject_id: id, course_id: object.id
                course_subject.destroy
              end

              flash[:success] = t "admin.actions.updated"
              redirect_to "#{show_course_path(Course, object)}#subject"
            end
          end
        end
      end
    end
  end
end
