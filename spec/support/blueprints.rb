require 'machinist/mongoid'

# Add your blueprints here.
#
# e.g.
#   Post.blueprint do
#     title { "Post #{sn}" }
#     body  { "Lorem ipsum..." }
#   end

User.blueprint do
  email { "user#{sn}@testing.com" }
  password {'password'}
  password_confirmation {'password'}
end


Client.blueprint do
  name{ "app#{sn}"}
  user
end
