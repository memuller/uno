require 'spec_helper'

describe "Sessions" do
  describe "session manupulation" do
    before :all do
      @user = User.make! :password => 'testing', :password_confirmation => 'testing'
    end

    it "should get session information" do
      post sessions_path , :session => {:email => @user.email, :password => 'testing'}
      get sessions_path
      JSON(response.body)['user_id'].should == @user.id.to_s
    end

    it "should not get sessions information when not logged in (404 instead)" do
      get sessions_path
      response.status.should == 404
    end

    it "should properly update session information" do
      post sessions_path , :session => {:email => @user.email, :password => 'testing'}
      put sessions_path, :new_info => 'new_value'
      response.status.should be 201
      get sessions_path
      JSON(response.body)['new_info'].should == 'new_value'
    end

    it "should fail to update inexistent sessions (406 instead)" do
      put sessions_path, :new_info => 'new_value'
      response.status.should == 406
    end
  end
end
