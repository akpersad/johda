Rails.application.routes.draw do


  get 'users/new'

  root to: 'johda#search'

  post 'johda/main'
  get '/johda/main'
  post 'menus/index'
  get "menus/index"
  # get 'johda', :to => 'johda#search'

  get   '/login', :to => 'sessions#new', :as => :login
  
  get '/auth/:provider/callback/', :to => 'sessions#create'
  
  get '/auth/failure', :to => 'sessions#failure'
 
end
