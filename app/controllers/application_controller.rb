class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :current_user

  helper_method :current_user, :not_authorized, :api_call_not_authorized

  def current_user
    @current_user ||= login_from_session
  end

  def login_from_session
    return nil unless session[:user_id]
    User.find(session[:user_id])
  end

  def store_location arg = '/'
    session[:return_to] = arg
  end

  def redirect_back_or_to_root
    target = session[:return_to]
    session[:return_to] = nil
    redirect_to (target ||= '/')
  end
  

  def not_authorized
    flash[:notice] = 'Please login.'
    store_location
    redirect_to new_session_path
  end

  def api_call_not_authorized(status = 401, text="")
    render :text => text, :status => status 
  end

end
