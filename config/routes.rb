Rails.application.routes.draw do

  resources :users
  # get 'users/new'

  root to: 'johda#search'

  post 'johda/main'
  get '/johda/main'
  post 'menus/index'
  get "menus/index"
  # get 'johda', :to => 'johda#search'
end
