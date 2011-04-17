require 'spec_helper'

describe ActionDispatch::Session::UnoStore::Session do
  before :all do
    @klass = ActionDispatch::Session::UnoStore::Session
    @user = User.make!
  end
  describe "its user relationships" do
    it "should have a user accessor" do
      @klass.create!.should respond_to :user
    end

    it "user accessor should return its current user" do
      @klass.create!({:user_id => @user.id}).user.should == @user
    end
  end
end
