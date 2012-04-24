class AddPrivilegeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :privilege, :string, :default => "user" #(1-user, 0-admin, 2-special user)

  end
end
