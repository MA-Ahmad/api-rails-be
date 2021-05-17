Rails.application.routes.draw do
  devise_for :users, path_prefix: "devise", controllers: { registrations: "registrations" }

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_scope :user do
        post "login" => "sessions#create", as: "login"
        post "signup", to: "registrations#create", as: 'signup'
        delete "logout" => "sessions#destroy", as: "logout"
        put "password/update", to: "registrations#update_password"
      end
    end
  end

  root "home#index"
  get '*path', to: 'home#index', via: :all
end
