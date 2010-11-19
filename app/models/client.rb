class Client
  include Mongoid::Document
  field :name, :type => String
  field :url, :type => String
  field :api_key, :type => String
end
