require 'spec_helper'

describe User do
  before :all do
    User.delete_all
  end
  describe "should have default attributes:" do
    it "email an e-mail" do
      User.new.should respond_to :email
    end
    it "a password_hash" do
      User.new.should respond_to :password_hash
    end
    it "a password setter/getter" do
      User.new.should respond_to :password
      User.new.should respond_to 'password='
    end
    it "timestamps" do
      User.new.should respond_to :created_at
      User.new.should respond_to :updated_at
    end
  end

  context 'validations' do
    it "email should be unique" do
      User.make! :email => 'repeat@test.com'
      User.make(:email => 'repeat@test.com').should_not be_valid
    end
    it "email should be formated like an e-mail" do
      User.make(:email => 'mail@mail.com').should be_valid
      User.make(:email => 'abc.com').should_not be_valid
    end
    it "password should have confirmation" do
      User.make(:password_confirmation => nil).should_not be_valid
      User.make(:password_confirmation => '').should_not be_valid
      User.make(:password => nil, :password_confirmation => nil).should_not be_valid
      User.make(:password => 'some', :password_confirmation => 'some').should be_valid
    end

  end
end
