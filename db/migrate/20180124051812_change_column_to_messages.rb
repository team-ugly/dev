class ChangeColumnToMessages < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :messages, :places
    remove_reference :messages, :place
  end
end
