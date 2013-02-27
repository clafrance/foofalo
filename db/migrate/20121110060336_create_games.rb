class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.string :name, :null => false, :limit => 50
      t.string :option1, :limit => 50
      t.string :option2, :limit => 50
      t.string :option3, :limit => 50
      t.string :option4, :limit => 50
      t.string :option5, :limit => 50
      t.string :option6, :limit => 50
      t.string :option7, :limit => 50
      t.string :option8, :limit => 50
      t.string :option9, :limit => 50
      t.string :option10, :limit => 50
      t.string :option11, :limit => 50
      t.string :option12, :limit => 50
      t.string :option13, :limit => 50
      t.string :option14, :limit => 50
      t.string :option15, :limit => 50
      t.string :option16, :limit => 50
      t.string :option17, :limit => 50
      t.string :option18, :limit => 50
      t.string :option19, :limit => 50
      t.string :option20, :limit => 50
      t.string :option21, :limit => 50
      t.string :option22, :limit => 50

      t.timestamps
    end
  end
end
