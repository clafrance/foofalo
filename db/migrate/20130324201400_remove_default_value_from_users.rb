class RemoveDefaultValueFromUsers < ActiveRecord::Migration
  def up
    change_column :users, :privilege, :string, :null => true    
  end

  def down
    change_column :users, :privilege, :string, :null => false 
  end
end
