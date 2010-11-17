class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :email, :type => String
  field :names_list, :type => Array, :default => []
  field :gender, :type => String
  field :location, :type => String

  field :password_hash, :type => String
  field :online, :type => Boolean, :default => false

  attr_accessor :password, :password_confirmation
  attr_accessor :full_name

  cattr_accessor :current, :profile_fields
  @@current = nil

  @@profile_fields = %w(full_name gender location bio)
  
  validates :gender, :inclusion => {:in => ['F', 'M']}, :unless => Proc.new{|u| u.gender.nil?}
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
  def name ; ( self.names_list[0] || self.email ); end
  def last_name ; self.names_list[-1] ; end
  def short_name ; "#{self.name} #{self.last_name}" ; end
  def long_name ; self.names_list * ' ' ; end
  def break_name!
    if self.full_name
      self.names_list = self.full_name.strip.split(' ')
    end
  end

  # Gender
  def male? ; self.gender == 'M' if self.gender; end
  def female? ; self.gender == 'F' if self.gender; end

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

  def find_session
    self.class.sessions.first(:conditions => {:user_id => self.id}) rescue nil
  end

  def session
    if session = find_session
      Marshal.load(session.data.unpack("m*").first)
    end
  end

  def session= arg
    if session = find_session
      arg.merge!({'user_id' => self.id})
      session.update_attributes(:data => [Marshal.dump(arg)].pack("m*"))
    end
  end

  def session_append arg
    if session = find_session
      arg.merge! self.session
      self.session = arg
    end
  end

  def session_destroy! controller
    if session = find_session
      controller.session.clear
      session.update_attributes(:user_id => nil)
      self.update_attributes(:online => false)
    end
  end

  def session_create controller
    raise ArgumentError unless controller.session.respond_to? '[]'
    controller.session[:user_id] = self.id
    self.update_attributes(:online => true)

  end




end

