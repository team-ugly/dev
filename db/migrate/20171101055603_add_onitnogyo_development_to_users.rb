class AddOnitnogyoDevelopmentToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :area_code, :integer
  end
end
