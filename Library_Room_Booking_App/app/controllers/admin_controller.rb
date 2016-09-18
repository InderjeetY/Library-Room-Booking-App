class AdminController < ApplicationController
  def index
    if session[:user_type] == 'member'
      @user = User.find_by(email_id: session[:email_id])
      if @user
        render '/admin/member'
      else
        redirect_to '/sessions/destroy'
      end
    else
      redirect_to '/sessions/destroy'
    end
  end
  def member
  end
  def sign_out
    redirect_to '/sessions/destroy'
  end
  def edit_user_details
    redirect_to '/users/' + User.find_by(email_id: session[:email_id]).id.to_s + '/edit'
  end
end
