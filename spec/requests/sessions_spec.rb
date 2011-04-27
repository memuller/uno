require 'spec_helper'

describe "Sessions" do
  describe "session manupulation" do
    before :all do
      @user = User.make! :password => 'testing', :password_confirmation => 'testing'
    end
    it "should get session information" do
      post sessions_path , :session => {:email => @user.email, :password => 'testing'}
      response.should redirect_to root_path
      get sessions_path
      JSON(response.body)['user_id'].should == @user.id.to_s
    end
  end
end
