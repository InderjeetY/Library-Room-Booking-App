Rails.application.routes.draw do
  resources :bookings, :only => [:index,	:new, :create, :edit, :update, :destroy]
  resources :rooms, :only => [:index,	:new, :create, :edit, :update, :destroy]
  #get 'admin/index'

  #get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  resources :users, :only => [:index,	:new, :create, :edit, :update, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => 'admin#index'
  #get 'sessions/destroy'
  #get 'sessions/create'
  #get 'sessions/new'

  post 'users/sign_up_member'
  post 'users/sign_up_admin'
  #get 'users/show_admins'
  post 'users/show_admins'
  post 'users/show_members'
  post 'users/Destroy'
  get 'users/allow_multiple_bookings' => 'users#allow_multiple_bookings'
  get 'users/remove_multiple_bookings' => 'users#remove_multiple_bookings'
  post 'admin/sign_out'
  post 'admin/edit_user_details'
  get 'admin/member_page'
  get 'admin/admin_page'

  post 'admin/create_room'
  post 'admin/show_all_rooms'
  post 'admin/admin_new'
  post 'admin/show_all_admin'
  post 'admin/find_rooms'
  post 'admin/show_my_bookings'

  post 'bookings/search_room'
  post 'bookings/search_rooms'
  #post 'bookings/book_room'
  get  'bookings/book_room'
  post 'bookings/find_rooms'
  post 'bookings/my_bookings'
  get 'bookings/my_bookings'
  get 'bookings/edit_booking'
  post 'bookings/update_booking'
  #get 'bookings/rooms_available'
  post 'bookings/rooms_available'
  delete 'bookings/destroy' => 'bookings#destroy'

  match 'rooms/room_schedule' => 'rooms#room_schedule', via: [:get, :post]
  #post 'rooms/room_schedule' => 'rooms#room_schedule'
  #map.connect 'rooms/room_schedule', :controller => 'rooms', :action => 'room_schedule', :conditions => { :method => :get }

  #get 'admin' => 'admin#index'
  get 'admin/index'
  controller :sessions do
    get 'login' => :new
    post 'login' => :create
    delete 'logout' => :destroy
  end
end
