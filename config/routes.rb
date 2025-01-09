Rails.application.routes.draw do
  root "home#index"
  resources :courses do
    resources :lessons
  end
  devise_for :admins, skip: [:registrations]
  devise_for :users
  authenticated :admin_user do
    root to: 'admin#index', as: :admin_root
  end
  resources :checkouts, only: [:create]
  get 'admin'=>"admin#index"
  post '/webhooks/stripe'=>"webhooks#stripe"
  namespace :admin do
    resources :courses do
      resources :lessons
    end
    resources :users
  end
  patch '/admin/courses/:course_id/lessons/:id/move'=>'admin/lessons#move'
end
