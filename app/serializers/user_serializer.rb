class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :sure_name, :auth_token
end