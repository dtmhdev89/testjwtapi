
Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resource :users, only: :create
  resources :recipes, except: [:new, :edit, :update]
  resources :books, only: [:index, :show]
  post "/login", to: "users#login"
  get "/auto_login", to: "users#auto_login"
  post "/generate_qrcode", to: "two_factor_authenticator#generate_qrcode"
  post "/enable_tfa", to: "two_factor_authenticator#enable_tfa"
end
