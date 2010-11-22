require 'spec_helper'

describe Client do
  describe "basic attributes" do
    it "should be a MongoID object" do
      Client.ancestors.should include Mongoid::Document
    end
    it "should have an url" do 
      Client.make.should respond_to :url
    end
    it "should have name" do 
      Client.make.should respond_to :name
    end
    it "should have timestamps" do 
      Client.make.should respond_to :created_at
      Client.make.should respond_to :updated_at
    end
  end

  describe "API key" do
    it "should have an API key" do
      Client.make.should respond_to :api_key
    end

    describe "its generate_api_key method" do
      it "should exist" do
        Client.make.should respond_to :generate_api_key
      end

      it "should return a key" do
        Client.make.generate_api_key.should be_a_kind_of String
      end
    end

    it "should generate a key before saving" do
      Client.make!.api_key.should_not be_empty
    end

    it "should not overwrite an existing key" do
      client = Client.make!
      old_key = client.api_key
      client.update_attributes!(:url => 'http://test.com')
      client.api_key.should == old_key
    end

    context "avoiding key collissions" do
      it "should re-generate the key if there's a collision"
      it "should keep re-generating until there's not a collision"
    end
  end

  describe "admin user relationships" do
    it "should refer to one admin" do
      Client.make.user.should be_a_kind_of User
    end
    it "should require an admin" do
      Client.make({:user => nil}).should_not be_valid
    end

    context "setting the admin user" do
      it "should have a admin_user_email accessor" do
        Client.make.should respond_to :admin_user_email
      end

      it "should set the said user as admin when present" do
        user = User.make!(:email => 'test@testing.com')
        Client.make!(:admin_user_email => user.email).user.should == user
      end

      it "should not set if we can't find an user with this email" do
        Client.make(:admin_user_email => 'none@exists.com').should_not be_valid
      end

      it "should fail if there's no user with this email, even if the previous one was valid" do
        user = User.make!
        client = Client.make!(:admin_user_email => user.email)
        client.admin_user_email = 'none@exists.com'
        client.should_not be_valid
      end
    end
  end



end
