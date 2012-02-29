class AddInformParentsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :inform_parents_token, :string

    add_column :users, :inform_parents_sent_at, :datetime
  end
end
