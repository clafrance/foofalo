class AddAuthorToFunFacts < ActiveRecord::Migration
  def change
    add_column :fun_facts, :user_id, :integer
    add_column :fun_facts, :author, :string, :limit => 50

  end
end
