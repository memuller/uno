require File.dirname(__FILE__) + '/acceptance_helper'

feature "Create User", %q{
  In order to use all Uno applications
  As someone that is not yet an user
  I want to create my account
} do

  before :all do
    @mail = 'test@testing.com'
    @pass = 'my pass'
    @wrong_pass = 'not my pass'
    @user = User.make!(:email => @mail)
  end

  scenario "Susccessfully creating an account" do
    visit '/users/new'
    fill_in 'user_email', :with => @mail
    fill_in 'user_password', :with => @pass
    fill_in 'user_password_confirmation', :with => @pass

    User.should_receive(:new).with({'email' => @mail, 'password' => @pass, 'password_confirmation' => @pass}).and_return(@user)

    User.should_receive(:find).and_return(@user)
    click_button 'Save'
    
    page.current_path.should == "/users/#{user.id}"
    page.should have_content @mail
  end


end
