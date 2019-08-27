Rails.application.routes.draw do
  resources :events
  devise_for :accounts

  get 'calendar(/:year_and_month)', to: 'calendar#show', as: :calendar_path
  root to: redirect('/calendar')

  resources :accounts, only: [:show]
end
