Rails.application.routes.draw do
  filter :locale
  root "courses#show"
  devise_for :users, path: "auth", path_names: {sign_in: "login", sign_out: "logout"}

  namespace :admin do
    resources :course_masters
    resources :courses do
      resources :subjects
      resource :assign_trainees
      resource :change_status_courses, only: :update
    end
    resources :roles
    resources :subjects
    resources :course_subjects do
      resources :user_subjects, only: :update do
      end
    end

    patch "status_subject/:course_subject_id/:status" => "status_subjects#update",
      as: :status_subject
  end

  resources :courses, only: :show do
    resources :subjects, only: [:show]
    resources :user_subjects, only: [:update, :show]
  end
  resources :users, only: [:edit, :update, :show] do
    resources :courses, only: :show do
      resources :subjects, only: :index
    end
  end
  resources :subjects, only: [:show]
  resources :user_tasks
end
