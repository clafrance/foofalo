class AddParentApprovedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :parent_approved, :string

    add_column :users, :parent_approved_at, :datetime
  end
end
