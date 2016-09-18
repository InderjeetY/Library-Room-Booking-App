class SessionsController < ApplicationController
  skip_before_action :authorize
  def new
  end

  def create
    user = User.find_by(email_id: params[:email_id])
    if user and user.authenticate(params[:password])
      session[:email_id] = user.email_id
      session[:user_type] = user.user_type
      redirect_to '/admin/index'
    else
      redirect_to login_url, alert:'Invalid email id or password'
    end
  end

  def destroy
    session[:email_id] = 'nil'
    session[:user_type] = 'nil'
    redirect_to login_url, alert:'Successfully logged out'
  end
end
