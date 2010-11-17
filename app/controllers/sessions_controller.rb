class SessionsController < ApplicationController

  def new
    if request.method.downcase == 'post'
      if user = User.authenticate(params[:email], params[:password])
        user.session_create(self)
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
    redirect_back_or_to_root
  end
end
