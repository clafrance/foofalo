class AddAuthorIdToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :author_id, :integer
  end
end
