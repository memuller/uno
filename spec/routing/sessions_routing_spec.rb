require "spec_helper"

describe SessionsController do
  describe "routing" do

    it "should not get #index" do
      { :get => "/sessions" }.should raise_error
    end

    it "recognizes and generates #new" do
      { :get => "/sessions/new" }.should route_to(:controller => "sessions", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/sessions" }.should route_to(:controller => "sessions", :action => "show")
    end

    it "recognizes and generates #edit" do
      { :get => "/sessions/edit" }.should route_to(:controller => "sessions", :action => "edit")
    end

    it "recognizes and generates #create" do
      { :post => "/sessions" }.should route_to(:controller => "sessions", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/sessions" }.should route_to(:controller => "sessions", :action => "update")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/sessions" }.should route_to(:controller => "sessions", :action => "destroy")
    end

    describe "routing shorthands" do
            
    end
  end
end
