class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.string :name, :null => false, :limit => 50, :unique => true
      t.text :content, :null => false
      t.integer :user_id, :null => false
      t.string :author, :null => false, :limit => 50
      t.integer :status, :null => false, :default => 0 #(0-need to be approved, 1-approved, 2-didn't get approved)
      t.string :message, :default => "new", :limit => 16
      t.timestamps :approved_at

      t.timestamps
    end
  end
end
