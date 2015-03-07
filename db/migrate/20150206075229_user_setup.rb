# Base User database migration to give
# minimal functionality to users on site
class UserSetup < ActiveRecord::Migration

  def up
    create_table :users do |t|
      t.column :user_id, :string, :limit => 36, :null => false
      t.column :user_username, :string, :limit => 64, :null => false
      t.column :user_firstname, :string, :limit => 64
      t.column :user_lastname, :string, :limit => 64
      t.column :user_middlename, :string, :limit => 64
      t.column :user_dateofbirth, :datetime
      t.column :user_verified, :boolean, :default => false
      t.column :verification_key, :string, :limit => 36
      t.column :verification_expiration, :datetime

      t.column :user_account_type, :string, :limit => 32, :null => false
      t.column :currently_logged_in, :boolean, :default => false
      t.column :last_logged_in, :datetime
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    create_table :passwords do |t|
      t.column :user_id, :string, :limit => 36, :null => false
      t.column :password_id, :string, :limit => 36, :null => false
      t.column :password_digest, :string, :limit => 256, :null => false
      t.column :reset_key, :string, :limit => 128
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end

    create_table :emails do |t|
      t.column :user_id, :string, :limit => 36, :null => false
      t.column :email_id, :string, :limit => 36, :null => false
      t.column :email_address, :string, :limit => 256, :null => false
      t.column :reset_key, :string, :limit => 36
      t.column :created_at, :datetime
      t.column :updated_at, :datetime
    end
  end

end