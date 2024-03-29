class SessionsController < ApplicationController

  def create
    if user = User.authenticate(params[:session][:email], params[:session][:password])
      user.session_create(self)
      flash[:notice] = 'You logged in sucessfully.'
      redirect_back_or_to_root
    elsif user == false
      flash[:error] = "Invalid password."
      redirect_to :new_session
    else
      flash[:error] = "It appears you don't have an account yet."
      redirect_to :new_user
    end
  end

  def new

  end

  def destroy
    current_user.session_destroy! self
    flash[:notice] = 'You have logged out.'
    redirect_back_or_to_root
  end

  def bar
    render :partial => 'sessions/bar'
  end

  def show
    if current_user
      render :text => session.to_json
    else
      api_call_not_authorized 404
    end
  end

  def update
    if current_user
      params.each do |k, v|
        session[k] = v
      end
      render :text => 'OK' , :status => 201
    else
      api_call_not_authorized 406
    end
  end
end
