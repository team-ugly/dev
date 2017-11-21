class WeatherForecastFetchController < ApplicationController
  require 'nokogiri'
  require 'open-uri'

  def index
    proxy_uri = 'http://proxy.oita-ct.ac.jp:80'
    prx_opt = {:proxy => proxy_uri}

    url = 'http://www.data.jma.go.jp/developer/xml/feed/regular_l.xml'
    xml = Nokogiri::XML(open(url,prx_opt).read)
    xml.remove_namespaces!
    entry_nodes = xml.xpath('//entry')

    entry_nodes.each do |entry|
      if '府県天気予報' === entry.xpath('title').text then
        if /.*大分.*/ === entry.xpath('content').text then
          puts "タイトル:" + entry.xpath('title').text
          puts "link:" + entry.xpath('link/@href').text
          puts "観測地点:" + entry.xpath('author/name').text
          puts "コンテンツ:" + entry.xpath('content').text
          forecast_xml_url = entry.xpath('link/@href').text
          forecast_xml = Nokogiri::XML(open(forecast_xml_url,prx_opt).read)
          forecast_xml.remove_namespaces!

          time_defines = forecast_xml.xpath('//TimeDefines')
          item_nodes = forecast_xml.xpath('//Item')
          item_nodes.each do |item|
            if '中部' === item.xpath('Area/Name').text then
              weatherForecastPart = item.xpath('.//WeatherForecastPart[@refID="1"]')[0]
              puts forecast_xml.xpath('//TimeDefine[@timeId="1"]')[0].xpath('DateTime').text + ":今日の中部の天気予報:" + weatherForecastPart.xpath('Sentence').text



              #weatherForecastテーブルにデータをinsert
              weatherForecast = Weatherforecast.new
              weatherForecast.area_code_forecast = 0
              weatherForecast.time_id_1 = time_defines[0].xpath('//TimeDefine[@timeId="1"]')[0].xpath('DateTime').text
              weatherForecast.time_id_2 = time_defines[0].xpath('//TimeDefine[@timeId="2"]')[0].xpath('DateTime').text
              weatherForecast.time_id_3 = time_defines[0].xpath('//TimeDefine[@timeId="3"]')[0].xpath('DateTime').text

              weatherForecast.weather_1 = weatherForecastPart.xpath('Sentence').text
              weatherForecast.weather_2 = item.xpath('.//WeatherForecastPart[@refID="2"]')[0].xpath('Sentence').text
              weatherForecast.weather_3 = item.xpath('.//WeatherForecastPart[@refID="3"]')[0].xpath('Sentence').text


              weatherForecast.wind_1 = item.xpath('.//WindForecastPart[@refID="1"]')[0].xpath('Sentence').text
              weatherForecast.wind_2 = item.xpath('.//WindForecastPart[@refID="2"]')[0].xpath('Sentence').text
              weatherForecast.wind_3 = item.xpath('.//WindForecastPart[@refID="3"]')[0].xpath('Sentence').text

              weatherForecast.rain_time_id_1 = item.xpath('//WindForecastPart[@refID="1"]')[0].xpath('Sentence').text


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

              weatherForecast.save

              break
            end
          end
          break
        end
      end

    end
  end

end
