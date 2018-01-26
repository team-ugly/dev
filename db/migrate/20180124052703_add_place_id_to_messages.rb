class AddPlaceIdToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :place_id, :integer
  end
end
