Rails.application.routes.draw do
  namespace :v1 do
    post 'user_token' => 'user_token#create'
    resources :restaurants
    resources :reservations
    resources :shifts
    resources :categories
  end
end
