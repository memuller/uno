class Client
  include Mongoid::Document
  include Mongoid::Timestamps
  field :name, :type => String
  field :url, :type => String
  field :api_key, :type => String

  references_one :user

  validates :user, :presence => true
end
