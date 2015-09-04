class Lab < ActiveRecord::Base

  belongs_to :teacher, :primary_key => 'user_id'

end