class InviteRequest < ActiveRecord::Migration
  create_table :invite_requests do |t|

    t.column :invite_request_id, :string, :limit => 36, :null => false
    t.column :invite_request_email_address, :string, :limit => 128, :null => false
    t.column :invite_request_granted, :boolean, :default => false
    t.column :invite_request_consumed, :boolean, :default => false
    t.column :created_at, :datetime
    t.column :updated_at, :datetime

  end
end
