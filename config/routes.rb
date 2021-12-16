Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :v1, defaults: { format: 'json' } do
    post 'authenticate', to: 'authentication#authenticate'
    post 'register', to: 'registration#create'
    get 'eliminate', to: 'restaurants#eliminate'
    resources :restaurants do
      get 'availability/:date', to: 'restaurants#availability'
    end
    resources :shifts
    resources :categories
    resources :reservations
  end
end
