# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  resources :roadmaps, only: :show do
    resources :nodes, only: :show
  end

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :members
    resources :roadmaps do
      member do 
        get :ui_settings
      end
      resources :nodes
    end

    resources :assessments, only: :create, module: 'assessments' do
      resources :questions
    end
  end

  namespace :student do
    get '/', to: 'dashboard#index'
    resources :roadmaps, only: %i[index show]
  end

  namespace :assessments do
    scope path: ':assessment_id' do
      resources :attempts, only: %i[new create]
    end

    resources :attempts, only: :show do
      member do
        patch :submit
      end

      resources :questions, only: %i[index] do
        collection do
          get ':index', to: 'questions#index'
        end

        resources :answers, only: :create
      end
    end
  end
end
