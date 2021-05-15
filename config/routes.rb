Rails.application.routes.draw do
  resources :logs, only: [:create, :index]

  root to: 'logs#index'
end
