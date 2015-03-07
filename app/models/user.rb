class User < ActiveRecord::Base

  has_one :email, :primary_key => 'user_id'
  has_one :password, :primary_key => 'user_id'
  has_one :auth_token, :primary_key => 'user_id'

end