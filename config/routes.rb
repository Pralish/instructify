Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  resources :roadmaps, only: :show do
    resources :nodes, only: :show
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :members
    resources :roadmaps do
      resources :nodes
    end 
  end

  namespace :student do
    get '/', to: 'dashboard#index'
    resources :roadmaps, only: %i[index show]
  end
end
