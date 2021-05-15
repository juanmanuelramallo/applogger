Rails.application.routes.draw do
  resources :logs, only: :create
end
