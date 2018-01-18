class CreateAreas < ActiveRecord::Migration[5.1]
  def change
    create_table :areas do |t|

      t.integer :area_code
      t.string :area_name
      t.integer :area_code_forecast

      t.timestamps

    end
  end
end
