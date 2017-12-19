namespace :weather_forecast_fetch do
  require 'nokogiri'
  require 'open-uri'

  desc "気象庁のATOMFeedからXMLをスクレイピングし天気予報をDBに格納する"
  task :fetch => :environment do
    proxy_uri = 'http://proxy.oita-ct.ac.jp:80'
    prx_opt = {:proxy => proxy_uri}

    feed_url = 'http://www.data.jma.go.jp/developer/xml/feed/regular_l.xml'
    #feed_xml = Nokogiri::XML(open(feed_url, prx_opt).read)
    feed_xml = Nokogiri::XML(open(feed_url).read)
    feed_xml.remove_namespaces!
    entry_nodes = feed_xml.xpath('//entry')

    entry_nodes.each do |entry|
      if '府県天気予報' === entry.xpath('title').text then
        if /.*大分.*/ === entry.xpath('content').text then
          puts "タイトル:" + entry.xpath('title').text
          puts "link:" + entry.xpath('link/@href').text
          puts "観測地点:" + entry.xpath('author/name').text
          puts "コンテンツ:" + entry.xpath('content').text
          forecast_xml_url = entry.xpath('link/@href').text
         # forecast_xml = Nokogiri::XML(open(forecast_xml_url, prx_opt).read)
          forecast_xml = Nokogiri::XML(open(forecast_xml_url).read)

          #forecast_xml.remove_namespaces!

          #namespaceを設定する
          namespaces = {
              "xmlns" => "http://xml.kishou.go.jp/jmaxml1/body/meteorology1/",
              "jmx_eb" => "http://xml.kishou.go.jp/jmaxml1/elementBasis1/"
          }

          time_series_info_nodes = forecast_xml.xpath('//xmlns:TimeSeriesInfo',namespaces)
          weatherForecastArr = [WeatherForecast.new, WeatherForecast.new, WeatherForecast.new, WeatherForecast.new,]

          weatherForecastArr[0].area_code_forecast = 0
          weatherForecastArr[1].area_code_forecast = 1
          weatherForecastArr[2].area_code_forecast = 2
          weatherForecastArr[3].area_code_forecast = 3

          #time_defines = forecast_xml.xpath('//TimeDefines')
          item_nodes_arr = time_series_info_nodes.map {|time_series_info| time_series_info.xpath('.//xmlns:Item',namespaces)}

          item_nodes_arr[0].zip(weatherForecastArr).each do |item, weatherForecast|
            #if '中部' === item.xpath('.//Area/Name').text then
            #weatherForecastPart = item.xpath('.//WeatherForecastPart[@refID="1"]')[0]

            #weatherForecastテーブルにデータをinsert
            #weatherForecast = WeatherForecast.new

            #weatherForecast.area_code_forecast = 0
            weatherForecast.time_id_1 = time_series_info_nodes[0].xpath('.//xmlns:TimeDefine[@timeId="1"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.time_id_2 = time_series_info_nodes[0].xpath('.//xmlns:TimeDefine[@timeId="2"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.time_id_3 = time_series_info_nodes[0].xpath('.//xmlns:TimeDefine[@timeId="3"]/xmlns:DateTime',namespaces)&.text


            weatherForecast.weather_1 = item.xpath('.//xmlns:WeatherForecastPart[@refID="1"]/xmlns:Sentence',namespaces)&.text
            weatherForecast.weather_2 = item.xpath('.//xmlns:WeatherForecastPart[@refID="2"]/xmlns:Sentence',namespaces)&.text
            weatherForecast.weather_3 = item.xpath('.//xmlns:WeatherForecastPart[@refID="3"]/xmlns:Sentence',namespaces)&.text

            weatherForecast.wind_1 = item.xpath('.//xmlns:WindForecastPart[@refID="1"]/xmlns:Sentence',namespaces)&.text
            weatherForecast.wind_2 = item.xpath('.//xmlns:WindForecastPart[@refID="2"]/xmlns:Sentence',namespaces)&.text
            weatherForecast.wind_3 = item.xpath('.//xmlns:WindForecastPart[@refID="3"]/xmlns:Sentence',namespaces)&.text


            #break
            #end
          end

          item_nodes_arr[1].zip(weatherForecastArr).each do |item, weatherForecast|

            weatherForecast.rain_time_id_1 = time_series_info_nodes[1].xpath('.//xmlns:TimeDefine[@timeId="1"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.rain_time_id_2 = time_series_info_nodes[1].xpath('.//xmlns:TimeDefine[@timeId="2"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.rain_time_id_3 = time_series_info_nodes[1].xpath('.//xmlns:TimeDefine[@timeId="3"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.rain_time_id_4 = time_series_info_nodes[1].xpath('.//xmlns:TimeDefine[@timeId="4"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.rain_time_id_5 = time_series_info_nodes[1].xpath('.//xmlns:TimeDefine[@timeId="5"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.rain_time_id_6 = time_series_info_nodes[1].xpath('.//xmlns:TimeDefine[@timeId="6"]/xmlns:DateTime',namespaces)&.text

            weatherForecast.rain_1 = item.xpath('.//jmx_eb:ProbabilityOfPrecipitation[@refID="1"]/@description',namespaces)&.text
            weatherForecast.rain_2 = item.xpath('.//jmx_eb:ProbabilityOfPrecipitation[@refID="2"]/@description',namespaces)&.text
            weatherForecast.rain_3 = item.xpath('.//jmx_eb:ProbabilityOfPrecipitation[@refID="3"]/@description',namespaces)&.text
            weatherForecast.rain_4 = item.xpath('.//jmx_eb:ProbabilityOfPrecipitation[@refID="4"]/@description',namespaces)&.text
            weatherForecast.rain_5 = item.xpath('.//jmx_eb:ProbabilityOfPrecipitation[@refID="5"]/@description',namespaces)&.text
            weatherForecast.rain_6 = item.xpath('.//jmx_eb:ProbabilityOfPrecipitation[@refID="6"]/@description',namespaces)&.text

          end

          item_nodes_arr[2].zip(weatherForecastArr).each do |item, weatherForecast|

            weatherForecast.max_min_temperature_time_id_1 = time_series_info_nodes[2].xpath('.//xmlns:TimeDefine[@timeId="1"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.max_min_temperature_time_id_2 = time_series_info_nodes[2].xpath('.//xmlns:TimeDefine[@timeId="2"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.max_min_temperature_time_id_3 = time_series_info_nodes[2].xpath('.//xmlns:TimeDefine[@timeId="3"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.max_min_temperature_time_id_4 = time_series_info_nodes[2].xpath('.//xmlns:TimeDefine[@timeId="4"]/xmlns:DateTime',namespaces)&.text

            #temperaturepartが３つしかない場合などがあるため対策が必要になると思われる
            weatherForecast.max_min_temperature_type_1 = item.xpath('.//jmx_eb:Temperature[@refID="1"]/@type',namespaces)&.text
            weatherForecast.max_min_temperature_type_2 = item.xpath('.//jmx_eb:Temperature[@refID="2"]/@type',namespaces)&.text
            weatherForecast.max_min_temperature_type_3 = item.xpath('.//jmx_eb:Temperature[@refID="3"]/@type',namespaces)&.text
            weatherForecast.max_min_temperature_type_4 = item.xpath('.//jmx_eb:Temperature[@refID="4"]/@type',namespaces)&.text

            weatherForecast.max_min_temperature_1 = item.xpath('.//jmx_eb:Temperature[@refID="1"]/@description',namespaces)&.text
            weatherForecast.max_min_temperature_2 = item.xpath('.//jmx_eb:Temperature[@refID="2"]/@description',namespaces)&.text
            weatherForecast.max_min_temperature_3 = item.xpath('.//jmx_eb:Temperature[@refID="3"]/@description',namespaces)&.text
            weatherForecast.max_min_temperature_4 = item.xpath('.//jmx_eb:Temperature[@refID="4"]/@description',namespaces)&.text
          end

          item_nodes_arr[3].zip(weatherForecastArr).each do |item, weatherForecast|

            weatherForecast.weather_detail_time_id_1 = time_series_info_nodes[3].xpath('.//xmlns:TimeDefine[@timeId="1"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.weather_detail_time_id_2 = time_series_info_nodes[3].xpath('.//xmlns:TimeDefine[@timeId="2"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.weather_detail_time_id_3 = time_series_info_nodes[3].xpath('.//xmlns:TimeDefine[@timeId="3"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.weather_detail_time_id_4 = time_series_info_nodes[3].xpath('.//xmlns:TimeDefine[@timeId="4"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.weather_detail_time_id_5 = time_series_info_nodes[3].xpath('.//xmlns:TimeDefine[@timeId="5"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.weather_detail_time_id_6 = time_series_info_nodes[3].xpath('.//xmlns:TimeDefine[@timeId="6"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.weather_detail_time_id_7 = time_series_info_nodes[3].xpath('.//xmlns:TimeDefine[@timeId="7"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.weather_detail_time_id_8 = time_series_info_nodes[3].xpath('.//xmlns:TimeDefine[@timeId="8"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.weather_detail_time_id_9 = time_series_info_nodes[3].xpath('.//xmlns:TimeDefine[@timeId="9"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.weather_detail_time_id_10 = time_series_info_nodes[3].xpath('.//xmlns:TimeDefine[@timeId="10"]/xmlns:DateTime',namespaces)&.text

            #8つしかない場合などがあるため対策が必要になると思われる
            weatherForecast.weather_detail_1 = item.xpath('.//jmx_eb:Weather[@refID="1"]',namespaces)&.text
            weatherForecast.weather_detail_2 = item.xpath('.//jmx_eb:Weather[@refID="2"]',namespaces)&.text
            weatherForecast.weather_detail_3 = item.xpath('.//jmx_eb:Weather[@refID="3"]',namespaces)&.text
            weatherForecast.weather_detail_4 = item.xpath('.//jmx_eb:Weather[@refID="4"]',namespaces)&.text
            weatherForecast.weather_detail_5 = item.xpath('.//jmx_eb:Weather[@refID="5"]',namespaces)&.text
            weatherForecast.weather_detail_6 = item.xpath('.//jmx_eb:Weather[@refID="6"]',namespaces)&.text
            weatherForecast.weather_detail_7 = item.xpath('.//jmx_eb:Weather[@refID="7"]',namespaces)&.text
            weatherForecast.weather_detail_8 = item.xpath('.//jmx_eb:Weather[@refID="8"]',namespaces)&.text
            weatherForecast.weather_detail_9 = item.xpath('.//jmx_eb:Weather[@refID="9"]',namespaces)&.text
            weatherForecast.weather_detail_10 = item.xpath('.//jmx_eb:Weather[@refID="10"]',namespaces)&.text

          end

          item_nodes_arr[4].zip(weatherForecastArr).each do |item, weatherForecast|

            weatherForecast.temperature_time_id_1 = time_series_info_nodes[4].xpath('.//xmlns:TimeDefine[@timeId="1"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.temperature_time_id_2 = time_series_info_nodes[4].xpath('.//xmlns:TimeDefine[@timeId="2"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.temperature_time_id_3 = time_series_info_nodes[4].xpath('.//xmlns:TimeDefine[@timeId="3"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.temperature_time_id_4 = time_series_info_nodes[4].xpath('.//xmlns:TimeDefine[@timeId="4"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.temperature_time_id_5 = time_series_info_nodes[4].xpath('.//xmlns:TimeDefine[@timeId="5"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.temperature_time_id_6 = time_series_info_nodes[4].xpath('.//xmlns:TimeDefine[@timeId="6"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.temperature_time_id_7 = time_series_info_nodes[4].xpath('.//xmlns:TimeDefine[@timeId="7"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.temperature_time_id_8 = time_series_info_nodes[4].xpath('.//xmlns:TimeDefine[@timeId="8"]/xmlns:DateTime',namespaces)&.text
            weatherForecast.temperature_time_id_9 = time_series_info_nodes[4].xpath('.//xmlns:TimeDefine[@timeId="9"]/xmlns:DateTime',namespaces)&.text

            #temperaturepartが３つしかない場合などがあるため対策が必要になると思われる
            weatherForecast.temperature_1 = item.xpath('.//jmx_eb:Temperature[@refID="1"]/@description',namespaces)&.text
            weatherForecast.temperature_2 = item.xpath('.//jmx_eb:Temperature[@refID="2"]/@description',namespaces)&.text
            weatherForecast.temperature_3 = item.xpath('.//jmx_eb:Temperature[@refID="3"]/@description',namespaces)&.text
            weatherForecast.temperature_4 = item.xpath('.//jmx_eb:Temperature[@refID="4"]/@description',namespaces)&.text
            weatherForecast.temperature_5 = item.xpath('.//jmx_eb:Temperature[@refID="5"]/@description',namespaces)&.text
            weatherForecast.temperature_6 = item.xpath('.//jmx_eb:Temperature[@refID="6"]/@description',namespaces)&.text
            weatherForecast.temperature_7 = item.xpath('.//jmx_eb:Temperature[@refID="7"]/@description',namespaces)&.text
            weatherForecast.temperature_8 = item.xpath('.//jmx_eb:Temperature[@refID="8"]/@description',namespaces)&.text
            weatherForecast.temperature_9 = item.xpath('.//jmx_eb:Temperature[@refID="9"]/@description',namespaces)&.text

          end


          #weatherForecastArr[0].save
          weatherForecastArr.each do |weatherForecast|
            weatherForecast.save
          end

          #一番新しい天気予報だけ取得したら抜ける
          break
        end
      end

    end
  end
end
