class AddAnswersToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :a, :string, :limit => 128

    add_column :challenges, :b, :string, :limit => 128

    add_column :challenges, :c, :string, :limit => 128

    add_column :challenges, :d, :string, :limit => 128

    add_column :challenges, :e, :string, :limit => 128

    add_column :challenges, :correct_col_name, :string, :limit => 16
    
    add_column :challenges, :correct_answer, :string, :limit => 128
    
    add_column :challenges, :explanation, :string, :limit => 500

  end
end
