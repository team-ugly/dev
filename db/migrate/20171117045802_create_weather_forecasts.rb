class CreateWeatherForecasts < ActiveRecord::Migration[5.1]
  def change
    create_table :weather_forecasts do |t|

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
      t.string :rain_4
      t.string :rain_5
      t.string :rain_6

      t.string :max_min_temperature_time_id_1
      t.string :max_min_temperature_time_id_2
      t.string :max_min_temperature_time_id_3
      t.string :max_min_temperature_time_id_4

      t.string :max_min_temperature_1
      t.string :max_min_temperature_2
      t.string :max_min_temperature_3
      t.string :max_min_temperature_4

      t.string :weather_detail_time_id_1
      t.string :weather_detail_time_id_2
      t.string :weather_detail_time_id_3
      t.string :weather_detail_time_id_4
      t.string :weather_detail_time_id_5
      t.string :weather_detail_time_id_6
      t.string :weather_detail_time_id_7
      t.string :weather_detail_time_id_8
      t.string :weather_detail_time_id_9
      t.string :weather_detail_time_id_10

      t.string :weather_detail_1
      t.string :weather_detail_2
      t.string :weather_detail_3
      t.string :weather_detail_4
      t.string :weather_detail_5
      t.string :weather_detail_6
      t.string :weather_detail_7
      t.string :weather_detail_8
      t.string :weather_detail_9
      t.string :weather_detail_10

      t.string :temperature_time_id_1
      t.string :temperature_time_id_2
      t.string :temperature_time_id_3
      t.string :temperature_time_id_4
      t.string :temperature_time_id_5
      t.string :temperature_time_id_6
      t.string :temperature_time_id_7
      t.string :temperature_time_id_8
      t.string :temperature_time_id_9

      t.string :temperature_1
      t.string :temperature_2
      t.string :temperature_3
      t.string :temperature_4
      t.string :temperature_5
      t.string :temperature_6
      t.string :temperature_7
      t.string :temperature_8
      t.string :temperature_9



      t.timestamps
    end
  end
end
