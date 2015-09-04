class BasicLabSetup < ActiveRecord::Migration
  create_table :labs do |t|

    t.column :user_id, :string, :limit => 36, :null => false
    t.column :lab_id, :string, :limit => 36, :null => false
    t.column :lab_title, :string, :limit => 96, :null => false
    t.column :lab_description, :string, :limit => 1048, :null => false
    t.column :lab_video_url, :string, :limit => 256
    t.column :created_at, :datetime
    t.column :updated_at, :datetime

  end
end