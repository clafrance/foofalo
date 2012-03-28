class CreateFunFacts < ActiveRecord::Migration
  def change
    create_table :fun_facts do |t|
      t.string :name, :null => false, :limit => 50, :unique => true
      t.text :content, :null => false
      t.integer :status, :null => false, :default => 1

      t.timestamps
    end
  end
end
