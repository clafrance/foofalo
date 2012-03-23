class AddPrivilegeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :privilege, :integer, :default => 1 #(1-user, 0-admin, 2-special user)

  end
end
