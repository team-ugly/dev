class CreateLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :logs do |t|

      t.timestamps

      t.string :log_title
      t.string :body
      t.integer :user_id
    end
  end
end
