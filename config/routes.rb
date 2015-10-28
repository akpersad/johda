Rails.application.routes.draw do


  root to: 'johda#search'

  post 'johda/main'
  get '/johda/main'
  post 'menus/index'
  get "menus/index"

  get   '/login', :to => 'sessions#new', :as => :login
  
  get '/auth/:provider/callback/', :to => 'sessions#create'
  
  get '/auth/failure', :to => 'sessions#failure'
 
end
