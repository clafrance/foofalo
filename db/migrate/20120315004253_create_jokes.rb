class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.string :name, :null => false, :limit => 50, :unique => true
      t.text :content, :null => false
      t.integer :user_id, :null => false
      t.string :author, :null => false, :limit => 50
      t.string :status, :null => false, :limit => 20, :default => "reviewing" #(0-need to be approved, 1-approved, 2-didn't get approved)
      t.string :message, :default => "new", :limit => 60
      t.timestamps :approved_at

      t.timestamps
    end
  end
end
