class AddAuthorToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :user_id, :integer
    add_column :challenges, :author, :string, :limit => 50

  end
end
