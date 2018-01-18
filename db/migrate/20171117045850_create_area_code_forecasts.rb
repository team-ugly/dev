class CreateAreaCodeForecasts < ActiveRecord::Migration[5.1]
  def change
    create_table :area_code_forecasts do |t|

      t.timestamps

      t.integer :area_code_forecast
      t.string :area_name
    end
  end
end
