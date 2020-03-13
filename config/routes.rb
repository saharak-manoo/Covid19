Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # Angular
  root 'homes#index'
  resources :home
  resources :covids, only: %i[index] do
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
