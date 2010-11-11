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

  context "basic profile info" do
    describe "names" do
      it "should have full_name as an array" do
        User.new.names_list.should be_a_kind_of Array
      end
      it "should default to an empty array" do
        User.new.names_list.should == []
      end
      it "should convert a string to an array on saving full_name" do
        User.make!(:full_name => 'Peter Pan').names_list.should == %w(Peter Pan)
      end
      describe "name getters" do
        before :all do
          @user = User.make!(:full_name => 'First Middle Last')
        end
        it "long_name should return full name as string" do
          @user.long_name.should == 'First Middle Last'
        end
        it "short_name should return only first and last name" do
          @user.short_name.should == 'First Last'
        end
        it "name should return return the first name" do
          @user.name.should == 'First'
        end
        it "last_name should return the last name" do
          @user.last_name == 'Last'
        end
      end
    end

    # Pending: Sex, Location, etc

  end

  describe "authentication procedures" do
    before :all do
      User.make!(3)
      @password = 'testing_pass'
      @user = User.make!(:password => @password, :password_confirmation => @password)
    end
    describe "its password in general" do
      it "should store a bcrypted hash of the password" do
        BCrypt::Password.new(@user.password_hash).should == @password
      end
    end
    describe "its password_match? method" do
      it "should return true when there is a match" do
        @user.password_match?(@password).should be true
      end
      it "should return false otherwise" do
        @user.password_match?('blaa').should be false
      end
    end
    describe "its authenticate method" do
      it "should return the user if it suceeds" do
        User.authenticate(@user.email, @password).should == @user
      end
      it "should return nil if there is no user found" do
        fake_mail = User.make.email
        User.authenticate(fake_mail, 'pass').should be nil
      end
      it "should return false if the password doesn't match" do
        User.authenticate(@user.email, 'this is so wrong').should be false
      end
    end
  end

end
