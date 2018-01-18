class CreateWeatherInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :weather_informations do |t|
      t.integer :area_code

      t.timestamps
    end
  end
end
