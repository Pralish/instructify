Rails.application.routes.draw do
  devise_for :users

  resources :roadmaps, only: :show

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :members
    resources :roadmaps do
      resources :steps, except: %i[index show]
    end 
  end

  namespace :student do
    get '/', to: 'dashboard#index'
    resources :roadmaps, only: %i[index show]
  end
end
