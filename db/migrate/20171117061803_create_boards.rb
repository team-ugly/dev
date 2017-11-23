class CreateBoards < ActiveRecord::Migration[5.1]
  def change
    create_table :boards do |t|

      t.timestamps

      t.string :username
      t.integer :user_id
      t.string :title
      t.string :body
      t.integer :flag
    end
  end
end
