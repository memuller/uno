class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, :type => String
  field :full_name, :type => String
  field :password_hash, :type => String

  attr_accessor :password, :password_confirmation

  validates :email, :uniqueness => true, :format => {:with => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/ }
  validate :password_checks

  # Checks if a password matches.
  def password_checks
    if not self.password or not self.password_confirmation
      self.password ||= ''
      self.errors.add password, "You need to fill in password and its confirmation"
      return false
    end
    unless self.password == self.password_confirmation
      self.errors.add self.password, "Password and its confirmation must match"
    end
  end

end
