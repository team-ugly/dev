class AddColumnToWeatherInformation < ActiveRecord::Migration[5.1]
  def change
    add_column :weather_informations, :time, :string
    add_column :weather_informations, :temperature, :string
    add_column :weather_informations, :rain, :string
    add_column :weather_informations, :wind_direction, :string
    add_column :weather_informations, :wind_speed, :string
    add_column :weather_informations, :sun, :string
  end
end
