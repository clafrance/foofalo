class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :name, :null => false, :limit => 30, :unique => true
      t.string :url
      t.string :category
      t.integer :user_id

      t.timestamps
    end
  end
end
