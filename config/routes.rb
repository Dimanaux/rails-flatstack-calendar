Rails.application.routes.draw do
  resources :events
  devise_for :accounts

  get 'calendar(/:year_and_month)', to: 'calendar#show', name: 'calendar'
  root to: 'calendar#show'
end
