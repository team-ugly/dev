class CreateWeatherforecasts < ActiveRecord::Migration[5.1]
  def change
    create_table :weatherforecasts do |t|

      t.integer :area_code_forecast, null:false

      t.string :time_id_1
      t.string :time_id_2
      t.string :time_id_3

      t.string :weather_1
      t.string :weather_2
      t.string :weather_3

      t.string :wind_1
      t.string :wind_2
      t.string :wind_3

      t.string :rain_time_id_1
      t.string :rain_time_id_2
      t.string :rain_time_id_3
      t.string :rain_time_id_4
      t.string :rain_time_id_5
      t.string :rain_time_id_6

      t.string :rain_1
      t.string :rain_2
      t.string :rain_3

      t.string :temperature_time_id_1
      t.string :temperature_time_id_2
      t.string :temperature_time_id_3
      t.string :temperature_time_id_4

      t.string :max_temperature_1
      t.string :max_temperature_2
      t.string :max_temperature_3
      t.string :max_temperature_4

      t.string :min_temperature_1
      t.string :min_temperature_2
      t.string :min_temperature_3
      t.string :min_temperature_4






      t.timestamps
    end
  end
end
