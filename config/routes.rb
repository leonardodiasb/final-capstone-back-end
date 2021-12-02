Rails.application.routes.draw do
  namespace :v1 do
    resources :restaurants
    resources :reservations
    resources :shifts
    resources :categories
  end  
end
