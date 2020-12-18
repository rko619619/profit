require 'curb'
require 'nokogiri'
require 'csv'

url_category = "http://loveread.ec/index_book.php?id_genre=1&p="

(1..10).each do |page|
  noke = Nokogiri::HTML(Curl::Easy.http_get("#{url_category.to_s}#{page}").body_str)
  (1..6).each do |number|
    global = noke.xpath("//table[#{number}][@class='table_gl']//div[@class='td_top_text']").text
    genre = noke.xpath("//table[#{number}][@class='table_gl']//tr[@class='td_top_color']//td[1]//p").text
    puts(global, genre)
  end
end



