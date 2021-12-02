Rails.application.routes.draw do
  namespace :v1, defaults: { format: 'json' } do
    post 'authenticate', to: 'authentication#authenticate'
    post 'register', to: 'registration#create'
  end
end
