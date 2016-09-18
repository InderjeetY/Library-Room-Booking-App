Rails.application.routes.draw do
  resources :bookings
  resources :rooms
  #get 'admin/index'

  #get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'admin#index'
  #get 'sessions/destroy'
  #get 'sessions/create'
  #get 'sessions/new'

  post 'users/sign_up'
  post 'admin/sign_out'
  post 'admin/edit_user_details'

  #get 'admin' => 'admin#index'
  get 'admin/index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
end
