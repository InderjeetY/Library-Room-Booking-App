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

  def show_all
    redirect_to '/rooms'
  end

  def admin_new
    redirect_to '/users/sign_up_admin'
  end

  def show_all_admin
    redirect_to '/users/show_admins'
  end


  def sign_out
    redirect_to '/sessions/destroy'
  end
  def edit_user_details
    redirect_to '/users/' + User.find_by(email_id: session[:email_id]).id.to_s + '/edit'
  end
end
