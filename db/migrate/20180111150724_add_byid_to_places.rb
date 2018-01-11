class AddByidToPlaces < ActiveRecord::Migration[5.1]
  def change
    add_column :places, :byid, :int
  end
end
