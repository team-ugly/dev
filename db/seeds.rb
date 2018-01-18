# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#国見、中津、豊後高田、杵築、院内、玖珠、湯布院、竹田、犬飼、宇目、佐伯、蒲江
#中部、北部、西部、南部
Area.create(area_code: 0 ,area_name: '国見' ,area_code_forecast: 1)
Area.create(area_code: 1 ,area_name: '中津' ,area_code_forecast: 1)
Area.create(area_code: 2 ,area_name: '豊後高田' ,area_code_forecast: 1)
Area.create(area_code: 3 ,area_name: '杵築' ,area_code_forecast: 0)
Area.create(area_code: 4 ,area_name: '院内' ,area_code_forecast: 1)
Area.create(area_code: 5 ,area_name: '玖珠' ,area_code_forecast: 2)
Area.create(area_code: 6 ,area_name: '湯布院' ,area_code_forecast: 0)
Area.create(area_code: 7 ,area_name: '竹田' ,area_code_forecast: 2)
Area.create(area_code: 8 ,area_name: '犬飼' ,area_code_forecast: 3)
Area.create(area_code: 9 ,area_name: '宇目' ,area_code_forecast: 3)
Area.create(area_code: 10 ,area_name: '佐伯' ,area_code_forecast: 3)
Area.create(area_code: 11 ,area_name: '蒲江' ,area_code_forecast: 3)

AreaCodeForecast.create(area_code_forecast: 0 ,area_name: '中部')
AreaCodeForecast.create(area_code_forecast: 1 ,area_name: '北部')
AreaCodeForecast.create(area_code_forecast: 2 ,area_name: '西部')
AreaCodeForecast.create(area_code_forecast: 3 ,area_name: '南部')

12.times do |area_code_number|
  24.times do |time_number|
    WeatherInformation.create(area_code: area_code_number ,time: time_number+1)
  end
end
4.times do |area_code_forecast_number|
  WeatherForecast.create(area_code_forecast: area_code_forecast_number)
end

Rake::Task['weather_forecast_fetch:fetch'].invoke
Rake::Task['weather_information_fetch:fetch'].invoke

