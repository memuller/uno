require 'spec_helper'

describe SessionsController do
  before :all do
    @user = User.make! :password => 'testing', :password_confirmation => 'testing' 
  end

  context "session authentication upon creation" do
    it "should try to authenticate an user" do
      User.should_receive(:authenticate).with(@user.email, 'testing')
      post :create, :session => {:email => @user.email, :password => 'testing'}
    end

    it "should accept right credentials and create a session" do
      post :create, :session => {:email => @user.email, :password => 'testing'}
      response.should redirect_to root_path
    end

    it "should fail to create sessions with wrong credentials" do
      post :create, :session => {:email => @user.email, :password => 'wrong'}
      response.should redirect_to new_session_path
    end

    it "should offer to create new user when email is not found" do
      post :create, :session => {:email => "inexistant"}
      response.should redirect_to new_user_path
    end
  end


end
