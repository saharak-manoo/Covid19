Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # Angular
  root 'homes#index'
  resources :home
  resources :covids, only: %i[index] do
    collection do
      get 'total'
      get 'retroact'
      get 'country'
      get 'country_retroact'
      get 'hospital'
    end
  end

  resources :line_bots do
    collection do
      post 'callback'
    end
  end  

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
