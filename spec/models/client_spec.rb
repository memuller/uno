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
  end
end
