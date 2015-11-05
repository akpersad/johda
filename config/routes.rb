Rails.application.routes.draw do



  resources :users

  # get    'help'    => 'static_pages#help'
  # get    'about'   => 'static_pages#about'
  # get    'contact' => 'static_pages#contact'
  get    'signup'  => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'


  # get 'users/new'
  post "/order" => "menus#order"
  get 'menus/order_confirm'
  post "/confirm" => "menus#confirm"


  root to: 'johda#search'

  post 'johda/main'
  get '/johda/main'
  post 'menus/index'
  get "menus/index"
  post 'johda/filter'
  # get 'johda', :to => 'johda#search'
end
