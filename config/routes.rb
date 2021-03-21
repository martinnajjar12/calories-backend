Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'measurements/create'
    end
  end
  mount_devise_token_auth_for 'User', at: 'auth'

  namespace :api do
    namespace :v1 do
      resources :measures
    end
  end
end
