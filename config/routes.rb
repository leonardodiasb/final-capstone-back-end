Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :v1, defaults: { format: 'json' } do
    post 'authenticate', to: 'authentication#authenticate'
    post 'register', to: 'registration#create'
    get 'users', to: 'users#index'
    resources :restaurants do
      get 'availability', to: 'restaurants#availability'
    end
    resources :shifts
    resources :categories
    resources :reservations
  end
end
