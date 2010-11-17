require 'spec_helper'

describe User do
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
        it "name shoud return the email if no name is given" do
          User.make(:email => 'test@testing.com').name.should == 'test@testing.com'
        end
      end
    end

    # Pending: Sex, Location, etc
    # Pending: @@profile_fields

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

  describe "session relastionships" do
    before :each do
      @user = User.make!
      @session = User.sessions.create! :user_id => @user.id
    end

    describe "its sessions method" do
      it "should exist" do
        User.should respond_to :sessions
      end
      it "should point to ActionDipatch::Session::UnoStore" do
        User.sessions.should == ActionDispatch::Session::UnoStore::Session
      end
    end
      
    describe "its session read method" do
      it "should exist" do
        User.make.should respond_to :session
      end
      context "when user has a session" do

        it "should not be nill" do
          @user.session.should_not be_nil
        end

        it "should be an hash of session data" do
          @user.session.should be_a_kind_of Hash
        end
      end

      context "when user has no session" do
        it "should return nil" do
          User.make.session.should be_nil
        end
      end
    end

    describe "its session write method" do
      it "should exist" do
        User.make.should respond_to :session=
      end

      it "should receive an argument" do
        lambda{ User.make.call('session=') }.should raise_error
        lambda{ User.make.session = 'arg' }.should_not raise_error
      end

      context "when there is a session" do
        it "should write the hash passed as arg to the session" do
          @user.session = {'test' => 'testing stuff'}
          @user.session.should include({'test' => 'testing stuff'})
        end

        describe "it should never overwrite the user_id" do
          it "should append the user it to the write" do
            @user.session = {'k' => 'v'}
            @user.session['user_id'].should == @user.id
            @user.session['k'].should == 'v'
          end
        end
      end

      context "when there is no session" do
        it "should return nil" do
          User.make.session = {'k' => 'v'}
        end
      end

    end

    describe "session_append" do
      it "should exist" do
        User.make.should respond_to :session_append
      end
      it "should merge the existing session with some new values" do
        @user.session = {'it' => 'should remain'}
        @user.session_append( {'this' => 'is new'} )
        @user.session.should include( {'it' => 'should remain'} )
        @user.session.should include( {'this' => 'is new'} )
      end
    end

    describe "session destruction - session_destroy!" do
      it "should exist" do
        User.make.should respond_to :session_destroy!
      end

      it "should completly wipeout the session" do
        controller = "" and controller.stub!(:session).and_return({})
        @user.session_destroy! controller
        @user.session.should be_nil
      end
    end
  end

  describe "session behavior" do
    describe "its current accessor" do
      it "should exist" do
        User.should respond_to :current
      end
      it "should default to nil" do
        User.current.should be_nil
      end
      it "should receive an user" do
        User.current = User.make!
        User.current.should be_a_kind_of User
      end
    end

    describe "its online accessor" do
      it "should exist" do
        User.make.should respond_to :online
      end
      it "should default to false" do
        User.make.online.should be false
      end
    end

  end
  describe "session creation and destruction" do

    before :each do
      @user = User.make!
      @session = User.sessions.create!({:user_id => @user.id})
      @user.session = ({'random' => 'data', 'just' => 'filling it'})
      @controller = 'controller' and @controller.stub!(:session).and_return({})
    end

    context "logging in" do
      it "should have a session_create method" do
        User.make.should respond_to :session_create
      end

      it "should receive a controller" do
        lambda{User.make.session_create}.should raise_error ArgumentError
        lambda{User.make.session_create(@controller)}.should_not raise_error
      end

      it "should set online to true" do
        @user.session_create @controller
        @user.online.should be true
      end

    end

    context "logging out" do
      it "should have a session_destroy method" do
        User.make.should respond_to :session_destroy!
      end

      it "should wipeout the session" do
        @user.session_destroy! @controller
        @user.session.should be nil
      end

      it "should set online to false" do
        @user.session_destroy! @controller
        @user.online.should be false
      end
    end
  end


end
