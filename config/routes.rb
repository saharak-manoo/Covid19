Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users

  # Angular
  root 'homes#index'
  resources :home
  resources :covids, only: %i[index] do
    collection do
      get 'confirmed'
      get 'total'
      get 'total_confirmed'
      get 'total_deaths'
      get 'total_recovered'
      get 'country'
      get 'timeseries_confirmed'
      get 'timeseries_deaths'
      get 'timeseries_recovered'
    end
  end

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
