class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|

      t.text :body
      t.integer :user_id
      t.text :user_name

      t.timestamps

    end
  end


end
