class AddColumnToWeatherForecasts < ActiveRecord::Migration[5.1]
  def change
    add_column :weather_forecasts, :max_min_temperature_type_1, :string
    add_column :weather_forecasts, :max_min_temperature_type_2, :string
    add_column :weather_forecasts, :max_min_temperature_type_3, :string
    add_column :weather_forecasts, :max_min_temperature_type_4, :string
  end
end
