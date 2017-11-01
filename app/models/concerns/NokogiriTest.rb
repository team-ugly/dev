
class NokogiriTest
  require 'nokogiri'
  require 'open-uri'


  url = 'http://www.data.jma.go.jp/developer/xml/feed/regular_l.xml'
  xml = Nokogiri::XML(open(url).read)
  xml.remove_namespaces!
  entry_nodes = xml.xpath('//entry')

  entry_nodes.each do |entry|
    puts "タイトル:" + entry.xpath('title').text
    puts "link:" + entry.xpath('link').attribute("href").text
    puts "観測地点:" + entry.xpath('author/name').text
  end

end