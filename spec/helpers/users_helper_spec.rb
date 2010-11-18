require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe UsersHelper do
  describe "the profile_field constructor" do
    it "should have the profile_field method" do
      helper.should respond_to :profile_field
    end
    it "should receive field_name as parameter" do
      lambda{helper.profile_field()}.should raise_error ArgumentError
      lambda{helper.profile_field(:name)}.should_not raise_error ArgumentError
    end
    it "should receive any other parameters" do
      lambda{helper.profile_field(:name, :thing => 'true')}.should_not raise_error ArgumentError
    end

    context "when building text fields" do
      describe "the result" do
        it "should have a label"
        it "its field id should be in the user_name format"
        it "its name should be in the user[name] format"

      end
    end

  end
  describe "profile form builder" do
  end
end
