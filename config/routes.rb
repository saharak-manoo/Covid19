Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # Angular
  root 'homes#index'
  resources :home
  namespace :api do
    resources :covids, only: %i[index] do
      collection do
        get 'total'
        get 'retroact'
        get 'country'
        get 'country_retroact'
        get 'hospital'
        get 'constants'
        get 'world'
        get 'cases'
        get 'trends'
        get 'summary_of_past_data'
        get 'cases_thai'
        get 'safe_zone'
      end
    end
  end

  resources :webhooks do
    collection do
      post 'callback'
    end
  end  

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
