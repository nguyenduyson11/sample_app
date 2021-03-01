Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "users#new"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    get "static_pages/home"
    get "static_pages/help"
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :users
    resources :account_activations, only: :edit
    resources :password_resets, except: %i(index show destroy)
    resources :microposts, only: %i(create destroy)
  end
end
