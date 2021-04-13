Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'measurements/create'
      get '/measures', to: 'measures#index'
      get '/calories', :to => 'measurements#show_calories'
    end
  end
  mount_devise_token_auth_for 'User', at: 'auth'
end
