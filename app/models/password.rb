class Password < ActiveRecord::Base
  belongs_to :user, primary_key: :user_id
  has_secure_password

end