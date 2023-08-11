Rails.application.routes.draw do
  devise_for :users

  resources :roadmaps, only: :show

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :members
  end
end
