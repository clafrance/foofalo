class AddAnswersToChallenges < ActiveRecord::Migration
  def change
    add_column :challenges, :answer1, :string, :limit => 128

    add_column :challenges, :answer2, :string, :limit => 128

    add_column :challenges, :answer3, :string, :limit => 128

    add_column :challenges, :answer4, :string, :limit => 128

    add_column :challenges, :answer5, :string, :limit => 128

    add_column :challenges, :correct, :string, :limit => 16
    
    add_column :challenges, :explanation, :string, :limit => 500

  end
end
