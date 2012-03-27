class CreateDisplayObjects < ActiveRecord::Migration
  def change
    create_table :display_objects do |t|
      t.string :obj_type, :null => false, :limit => 30, :unique => true
      t.integer :obj_id

      t.timestamps
    end
  end
end