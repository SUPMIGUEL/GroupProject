Rails.application.routes.draw do

  root 'sessions#home' 

  get '/login', to: "sessions#login", as: 'login'
  get '/signup', to: "users#signup", as: 'signup'
  post '/login', to: "sessions#attempt_login"
  post '/signup', to: "users#create"
  get '/home', to: "sessions#home", as: 'home'
  delete '/logout', to: "sessions#logout", as: "logout"

  resources :schools
  
  resources :users, shallow:true do 
      resources :reviews
  end

  get '/admin', to: "users#admin", as: 'admin'
  
  resources :resets, only:[:new, :edit, :create, :update]
 
end
