class Client
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :type => String
  field :url, :type => String
  field :api_key, :type => String

  references_one :user

  validates :user, :presence => true
  
  before_save do |obj|
    obj.api_key = generate_api_key
  end
    
  # API keys
  def generate_api_key
    Digest::SHA1.hexdigest("#{Time.now.to_s}")
  end
    
end
