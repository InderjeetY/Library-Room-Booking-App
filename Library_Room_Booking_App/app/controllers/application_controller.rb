class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authorize
  protected
  def authorize
    unless User.find_by(email_id: session[:email_id])
      redirect_to login_url, notice: 'Cannot access without login'
    end
  end
end
