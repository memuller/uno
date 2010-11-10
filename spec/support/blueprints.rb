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
  password {'something'}
  password_confirmation {'something'}
end

