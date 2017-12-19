
class NokogiriTestSchool
  require 'nokogiri'
  require 'open-uri'



  proxy_uri = 'http://proxy.oita-ct.ac.jp:80'
  prx_opt = {:proxy => proxy_uri}

  url = 'http://www.data.jma.go.jp/developer/xml/feed/regular_l.xml'
  xml = Nokogiri::XML(open(url,prx_opt).read)
  #xml = Nokogiri::XML(open(url).read)
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
        #forecast_xml = Nokogiri::XML(open(forecast_xml_url).read)

        #namespaceを設定する
        namespaces = {
            "xmlns" => "http://xml.kishou.go.jp/jmaxml1/body/meteorology1/",
            # "jmx" => "http://xml.kishou.go.jp/jmaxml1/",
            # "jmx_add" => "http://xml.kishou.go.jp/jmaxml1/addition1/",
            "jmx_eb" => "http://xml.kishou.go.jp/jmaxml1/elementBasis1/"
        }
        #forecast_xml.remove_namespaces!


        time_series_info_nodes = forecast_xml.xpath('//xmlns:TimeSeriesInfo',namespaces)
        # item_nodes = forecast_xml.xpath('//Item')
        item_nodes_arr = time_series_info_nodes.map {|time_series_info| time_series_info.xpath('.//xmlns:Item',namespaces)}

        item_nodes_arr[1].each do |item|

            # weatherForecastPart = item.xpath('//WeatherForecastPart[@refID="1"]')[0]
            # puts forecast_xml.xpath('//TimeDefine[@timeId="1"]')[0].xpath('DateTime').text + ":今日の中部の天気予報:" + weatherForecastPart.xpath('Sentence').text


          puts ""

            # puts time_series_info_nodes[0].xpath('.//TimeDefine[@timeId="1"]')[0].xpath('DateTime').text
            # puts time_series_info_nodes[0].xpath('.//TimeDefine[@timeId="2"]')[0].xpath('DateTime').text
            # puts time_series_info_nodes[0].xpath('.//TimeDefine[@timeId="3"]')[0].xpath('DateTime').text
            #
            #
            # puts item.xpath('.//WeatherForecastPart[@refID="1"]')[0].xpath('Sentence').text
            # puts item.xpath('.//WeatherForecastPart[@refID="2"]')[0].xpath('Sentence').text
            # puts item.xpath('.//WeatherForecastPart[@refID="3"]')[0].xpath('Sentence').text
            #
            # puts item.xpath('.//WindForecastPart[@refID="1"]')[0].xpath('Sentence')&.text
            # puts item.xpath('.//WindForecastPart[@refID="2"]')[0].xpath('Sentence')&.text
            # puts item.xpath('.//WindForecastPart[@refID="3"]')[0].xpath('Sentence').text


          puts time_series_info_nodes[1].xpath('.//xmlns:TimeDefine[@timeId="1"]/xmlns:DateTime',namespaces)&.text
          puts time_series_info_nodes[1].xpath('.//xmlns:TimeDefine[@timeId="2"]/xmlns:DateTime',namespaces)&.text
          puts time_series_info_nodes[1].xpath('.//xmlns:TimeDefine[@timeId="3"]/xmlns:DateTime',namespaces)&.text
          puts time_series_info_nodes[1].xpath('.//xmlns:TimeDefine[@timeId="4"]/xmlns:DateTime',namespaces)&.text
          puts time_series_info_nodes[1].xpath('.//xmlns:TimeDefine[@timeId="5"]/xmlns:DateTime',namespaces)&.text
          puts time_series_info_nodes[1].xpath('.//xmlns:TimeDefine[@timeId="6"]/xmlns:DateTime',namespaces)&.text

          #puts item&.text

          puts item.xpath('.//jmx_eb:ProbabilityOfPrecipitation[@refID="1"]/@description',namespaces)&.text
          puts item.xpath('.//jmx_eb:ProbabilityOfPrecipitation[@refID="2"]/@description',namespaces)&.text
          puts item.xpath('.//jmx_eb:ProbabilityOfPrecipitation[@refID="3"]/@description',namespaces)&.text
          puts item.xpath('.//jmx_eb:ProbabilityOfPrecipitation[@refID="4"]/@description',namespaces)&.text
          puts item.xpath('.//jmx_eb:ProbabilityOfPrecipitation[@refID="5"]/@description',namespaces)&.text
          puts item.xpath('.//jmx_eb:ProbabilityOfPrecipitation[@refID="6"]/@description',namespaces)&.text





        end
        break
      end
    end

  end


end