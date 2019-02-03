class CreateLearnTips < ActiveRecord::Migration[5.2]
  def change
    create_table :learn_tips do |t|

      t.timestamps
    end
  end
end
