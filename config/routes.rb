Rails.application.routes.draw do
  root 'users#index'
  resources :users, :sessions, :secrets, :likes
  post 'secrets/:id/create' => 'secrets#create'
end
