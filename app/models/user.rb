class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, :type => String
  field :names_list, :type => Array, :default => []
  field :password_hash, :type => String

  attr_accessor :password, :password_confirmation
  attr_accessor :full_name

  validates :email, :presence => true, :uniqueness => true, :format => {:with => /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$/ }
  validate :password_checks
  
  before_save :break_name!, :hash_password!

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
  
  # Name stuff
  def name ; self.names_list[0] ; end
  def last_name ; self.names_list[-1] ; end
  def short_name ; "#{self.name} #{self.last_name}" ; end
  def long_name ; self.names_list * ' ' ; end
  def break_name!
    if self.full_name
      self.names_list = self.full_name.strip.split(' ')
    end
  end
  
  # Authentication methods
  def hash_password!
    if self.password
      self.password_hash = BCrypt::Password.create(self.password)
    end
  end

  def password_match? arg
    BCrypt::Password.new(self.password_hash) == arg
  end

  def self.authenticate mail, pass
    return nil unless user = User.first(:conditions => { :email => mail } )
    return user if user.password_match? pass
    false
  end

  # Session relationships
  def self.sessions ; ActionDispatch::Session::UnoStore::Session ; end
  def session
    if session = self.class.sessions.first(:conditions => {:user_id =>self.id })
      Marshal.load(session.data.unpack("m*").first)
    else
      nil
    end
  end


end
