class CreateJokes < ActiveRecord::Migration
  def change
    create_table :jokes do |t|
      t.string :name, :null => false, :limit =>50, :unique => true
      t.text :content, :null => false
      t.string :author, :null => false
      t.integer :status, :null => false, :default => 0

      t.timestamps
    end
  end
end
