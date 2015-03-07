class AuthToken < ActiveRecord::Base

  belongs_to :user, :primary_key => 'user_id'

  before_create :set_defaults

  def set_defaults
    self.auth_token_id = SecureRandom.uuid
    self.auth_token_expires = 24.hour.from_now
  end

end