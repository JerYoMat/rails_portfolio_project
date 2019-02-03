class CreateLearnTips < ActiveRecord::Migration[5.2]
  def change
    create_table :learn_tips do |t|
      t.string :name 
      t.string :link 
      t.text :description
      t.belongs_to :user 
      t.belongs_to :lesson
      t.timestamps
    end
  end
end
