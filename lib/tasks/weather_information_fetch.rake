namespace :weather_information_fetch do
  require 'nokogiri'
  require 'open-uri'

  desc "気象庁のアメダスのデータをスクレイピングしDBに格納する"
  task :fetch => :environment do

    proxy_uri = 'http://proxy.oita-ct.ac.jp:80'
    prx_opt = {:proxy => proxy_uri}

    #国見、中津、豊後高田、杵築、院内、玖珠、湯布院、竹田、犬飼、宇目、佐伯、蒲江
    url_parts = ['83021','83051','83061','83121','83106','83191','83201','83371','83341','83431','83401','83476']
    #url = ['http://www.jma.go.jp/jp/amedas_h/today-83021.html?areaCode=000&groupCode=59','http://www.jma.go.jp/jp/amedas_h/today-83051.html?areaCode=000&groupCode=59']

    #weatherinformation

    area_codes = ['0','1','2','3','4','5','6','7','8','9','10','11']

    url_parts.zip(area_codes).each  do |url_part,area_code|
      url = "http://www.jma.go.jp/jp/amedas_h/today-#{url_part}.html?areaCode=000&groupCode=59"
      #doc = Nokogiri::HTML(open(url, prx_opt))
      doc = Nokogiri::HTML(open(url))

      #feed_xml = Nokogiri::XML(open(feed_url).read)
      #puts doc.xpath('//body/div[@id="base"]/div[@id="main"]/div[@id="info"]/div[@id="main_table"]/div[@id="div_table"]/table[@id="tbl_list"]')&.text
      puts ""

      #find
      trList = doc.xpath('//body/div[@id="base"]/div[@id="main"]/div[@id="info"]/div[@id="main_table"]/div[@id="div_table"]/table[@id="tbl_list"]/tr')


      # puts "time" + trList[2].xpath('.//td')[0].text
      # puts "temp" + trList[2].xpath('.//td')[1].text
      # puts "rain" + trList[2].xpath('.//td')[2].text
      # puts "wind_d" + trList[2].xpath('.//td')[3].text
      # puts "wind_s" + trList[2].xpath('.//td')[4].text
      #puts "sun" +  trList[0].xpath('.//tr')[2].xpath('.//td')[5].text.blank? ? nil:tableList[0].xpath('.//tr')[2].xpath('.//td')[5].text

      trList.each_with_index do |tr,index|
        if(index >= 2) then
          weatherInformation = WeatherInformation.new
          weatherInformation.area_code = area_code
          weatherInformation.time = tr.xpath('.//td')[0].text
          #空白の時nilを保存する
          tr.xpath('.//td')[1].text.blank? ? weatherInformation.temperature = nil: weatherInformation.temperature = tr.xpath('.//td')[1].text
          tr.xpath('.//td')[2].text.blank? ? weatherInformation.rain = nil: weatherInformation.rain = tr.xpath('.//td')[2].text
          tr.xpath('.//td')[3].text.blank? ? weatherInformation.wind_direction = nil: weatherInformation.wind_direction = tr.xpath('.//td')[3].text
          tr.xpath('.//td')[4].text.blank? ? weatherInformation.wind_speed = nil: weatherInformation.wind_speed = tr.xpath('.//td')[4].text
          tr.xpath('.//td')[5].text.blank? ? weatherInformation.sun = nil: weatherInformation.sun = tr.xpath('.//td')[5].text

          weatherInformation.save
        end
      end

      #break

    end


  end

end
