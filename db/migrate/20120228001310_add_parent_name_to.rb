class AddParentNameTo < ActiveRecord::Migration
  def up
    add_column :users, :parent_firstname, :string
    add_column :users, :parent_lastname, :string
  end

  def down
  end
end
