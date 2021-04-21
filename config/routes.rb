Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :measures, only: [:index, :show]
      resources :measurements, only: [:create]
    end
  end
  mount_devise_token_auth_for 'User', at: 'auth'
end
