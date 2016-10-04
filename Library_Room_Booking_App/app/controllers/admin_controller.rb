class AdminController < ApplicationController
  def index
    @user = User.find_by(email_id: session[:email_id])
    if @user
       if session[:user_type] == 'member'
        redirect_to '/admin/member_page'
       elsif session[:user_type] == 'admin' || session[:user_type] == 'sadmin'
         redirect_to '/admin/admin_page'
       end
    else
         redirect_to '/sessions/destroy'
    end
  end

  def member_page
    @user = User.find_by(email_id: session[:email_id])
  end

  def admin_page
    @user = User.find_by(email_id: session[:email_id])
  end

  def create_room
    redirect_to '/rooms/new'
  end

  def show_all_rooms
    redirect_to '/rooms'
  end

  def find_rooms
    redirect_to '/bookings/search_rooms'
  end

  def show_my_bookings
    redirect_to '/bookings/my_bookings'
  end

  def sign_out
    redirect_to '/sessions/destroy'
  end
  def edit_user_details
    redirect_to '/users/' + User.find_by(email_id: session[:email_id]).id.to_s + '/edit'
  end
end
