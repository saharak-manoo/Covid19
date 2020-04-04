Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/saharak/db/admin', as: 'rails_admin'
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
        get 'infected_by_province'
        get 'hospital_and_labs'
        get 'thai_ddc'
        get 'thai_separate_province'
        get 'global_confirmed'
        get 'global_confirmed_add_today'
        get 'global_recovered'
        get 'global_critical'
        get 'global_deaths'
        get 'global_deaths_add_today'
        get 'thailand_summary'
        get 'global_summary'
        get 'thailand_retroact'
        get 'global_retroact'
        get 'thailand_cases'
        get 'thailand_infected_province'
        get 'hospital_by_location'
        get 'thailand_case_by_location'
        get 'thailand_today'
        get 'thailand_timeline'
        get 'thailand_area'
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
