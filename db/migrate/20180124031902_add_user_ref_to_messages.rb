class AddUserRefToMessages < ActiveRecord::Migration[5.1]
  def change
    add_reference :messages, :place, foreign_key: true
  end
end
