class CreateFarms < ActiveRecord::Migration[5.1]
  def change
    create_table :farms do |t|

      t.integer :user_id, foreign_key: true
      t.timestamps

      t.string :farm_name
      t.string :farm_address
      t.string :varchar

    end
  end
end
