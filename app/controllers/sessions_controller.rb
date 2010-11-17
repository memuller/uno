class SessionsController < ApplicationController

  def new
    redirect_to(:action => :destroy) if current_user
    if request.method.downcase == 'post'
      if user = User.authenticate(params[:email], params[:password])
        user.session_create(self)
        flash[:notice] = 'You logged in sucessfully.'
        redirect_back_or_to_root
      elsif user == false
        flash[:error] = "Invalid password."
      else
        flash[:error] = "It appears you don't have an account yet."
      end
    end
  end

  def destroy
    current_user.session_destroy! self
    flash[:notice] = 'You have logged out.'
    redirect_back_or_to_root
  end

  def bar
    render :partial => 'sessions/bar'
  end
end
