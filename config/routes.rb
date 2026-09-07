Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: "users/sessions",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    passwords: "users/passwords"
  }

  root "home#index"

  resources :courses do
    resources :modules, controller: "course_modules", only: [:create, :update, :destroy]
    resources :enrollments, only: [:create, :destroy]
    resources :discussion_topics, only: [:index, :create, :update, :destroy]
    resources :quizzes, only: [:index, :create, :update, :destroy]
    member do
      get :students
      get :analytics
    end
  end

  resources :course_modules, only: [:show] do
    resources :lessons, only: [:create, :update, :destroy, :show]
  end

  resources :lessons, only: [] do
    post :complete, on: :member
    delete :incomplete, on: :member
  end

  resources :quizzes, only: [] do
    resources :quiz_submissions, only: [:create, :show, :update]
    post :start, on: :member
    post :submit, on: :member
  end

  resources :quiz_submissions, only: [] do
    post :grade, on: :member
  end

  resources :payments, only: [:index, :create, :show]
  post "payments/webhook", to: "payments#webhook"

  resources :certificates, only: [:index, :show]
  get "certificates/:code/verify", to: "certificates#verify"

  resources :notifications, only: [:index, :update] do
    patch :mark_all_read, on: :collection
  end

  resources :users, only: [:show, :update]
  get "dashboard", to: "dashboard#index"
  get "dashboard/instructor", to: "dashboard#instructor"
  get "dashboard/admin", to: "dashboard#admin"

  namespace :api do
    namespace :v1 do
      resources :courses, only: [:index, :show]
      resources :enrollments, only: [:create, :destroy]
      resources :quiz_submissions, only: [:create, :show]
      post "payments/webhook", to: "payments#webhook"
    end
  end

  get "search", to: "search#index"
  get "health", to: "health_check#show"
end
