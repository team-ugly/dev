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

    area_codes = ['0','1','2','3','4','5','6','7','8','9','10','11']
    url_parts.zip(area_codes).each  do |url_part,area_code|
      url = "http://www.jma.go.jp/jp/amedas_h/today-#{url_part}.html?areaCode=000&groupCode=59"
      doc = Nokogiri::HTML(open(url, prx_opt))

      #feed_xml = Nokogiri::XML(open(feed_url).read)
      puts doc.xpath('//body/div[@id="base"]/div[@id="main"]/div[@id="info"]/div[@id="main_table"]/div[@id="div_table"]/table[@id="tbl_list"]')&.text
      puts ""
      break
    end


  end

end
