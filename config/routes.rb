Rails.application.routes.draw do
  mount Ckeditor::Engine => "/ckeditor"
  filter :locale
  root "static_pages#home"

  devise_for :users, path: "auth", path_names: {sign_in: "login", sign_out: "logout"}

  namespace :admin do
    resources :course_masters
    resources :courses do
      resources :subjects, only: :show
      resource :assign_trainers, only: [:edit, :update]
      resource :assign_trainees, only: [:edit, :update]
      resource :change_status_courses, only: :update
      resources :course_subjects, only: :index
    end
    resources :roles do
      resource :allocate_permissions
    end
    resources :subjects do
      resources :task_masters, only: :index
    end
    resources :course_subjects do
      resources :user_subjects, only: :update
    end
    resources :users do
      resource :evaluations
      resources :notes
    end

    resources :evaluations, only: :index

    patch "status_subject/:course_subject_id/:status" => "status_subjects#update",
      as: :status_subject
    resources :evaluation_templates
    resources :ranks
    resources :universities, except: :show
    resources :programming_languages, except: :show
    resources :statuses, except: :show
    resources :user_types, except: :show
    resources :profiles
    resources :user_progresses, except: :show
  end

  resources :courses, only: :show do
    resources :subjects, only: [:index, :show]
    resources :tasks
    resources :user_subjects, only: [:update, :show]
  end
  resources :users, only: [:edit, :update, :show] do
    resource :profiles
  end
  resources :subjects, only: [:show]
  resources :user_tasks
  resources :user_courses, :show
end
