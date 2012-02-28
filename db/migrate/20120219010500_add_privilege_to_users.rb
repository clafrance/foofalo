class AddPrivilegeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :privilege, :integer, :default => 1

  end
end
