
class NokogiriTest
  require 'nokogiri'
  require 'open-uri'

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
        puts "link:" + entry.xpath('link').attribute("href").text
        puts "観測地点:" + entry.xpath('author/name').text
        puts "コンテンツ:" + entry.xpath('content').text
        forecast_xml_url = entry.xpath('link').attribute("href").text
        forecast_xml = Nokogiri::XML(open(forecast_xml_url,prx_opt).read)
        forecast_xml.remove_namespaces!

        detailForecast_nodes = forecast_xml.xpath('//DetailForecast')
        detailForecast_nodes.each do |a|
          if '1' === a.xpath('WeatherForecastPart').attribute("refID").text
            puts "今日の天気予報:" + a.xpath('Sentence').text
          end
        end
      end
    end

  end

end