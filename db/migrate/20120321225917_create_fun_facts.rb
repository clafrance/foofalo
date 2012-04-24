class CreateFunFacts < ActiveRecord::Migration
  def change
    create_table :fun_facts do |t|
      t.string :name, :null => false, :limit => 50, :unique => true
      t.text :content, :null => false
      t.string :status, :null => false, :limit => 20, :default => "new"

      t.timestamps
    end
  end
end
