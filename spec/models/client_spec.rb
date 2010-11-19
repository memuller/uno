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

  describe "user relationships" do
    it "should refer to one admin" do
      Client.make.user.should be_a_kind_of User
    end
    it "should require an admin" do
      Client.make({:user => nil}).should_not be_valid
    end
  end
end
