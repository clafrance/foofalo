class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers, :id => false do |t|
      t.integer :user_id
      t.integer :challenge_id
      t.string :challenge_name, :limit => 50
      t.string :answer_selected, :limit => 128
      t.string :reason, :limit => 500
      t.string :correct

      t.timestamps
    end
  end
end
