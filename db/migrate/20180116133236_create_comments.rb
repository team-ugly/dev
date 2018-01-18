class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :byname
      t.string :com

      t.timestamps
    end
  end
end
