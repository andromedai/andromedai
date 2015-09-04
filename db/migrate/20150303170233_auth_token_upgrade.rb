class AuthTokenUpgrade < ActiveRecord::Migration
  def up
    create_table :auth_tokens do |t|

      t.column :auth_token_id, :string, :limit => 36, :null => false
      t.column :user_id, :string, :limit => 36, :null => false
      t.column :auth_token_expires, :datetime, :null => false
      t.column :created_at, :datetime
      t.column :updated_at, :datetime

    end
  end
end
