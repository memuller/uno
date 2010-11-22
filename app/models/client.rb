class Client
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :type => String
  field :url, :type => String
  field :api_key, :type => String

  references_one :user

  attr_accessor :admin_user_email

  validates :user, :presence => true
  
  # Sets the admin user by using its email
  before_validation do |obj|
    if obj.admin_user_email
      if user = User.where(:email => obj.admin_user_email).first
        self.user = user
      else
        errors.add admin_user_email, "Invalid email for the admin user."
        false
      end
    end
  end

  # Generates an api key when there isn't one
  before_save do |obj|
    obj.api_key = generate_api_key unless obj.api_key
  end
    
  # API keys
  def generate_api_key
    Digest::SHA1.hexdigest("#{Time.now.to_s}")
  end
    
end
