require 'curb'
require 'nokogiri'
require 'csv'
require 'time'

url_category = "http://loveread.ec/index_book.php?id_genre=1&p="
global = []
(1..1).each do |page|
  noke = Nokogiri::HTML(Curl::Easy.http_get("#{url_category.to_s}#{page}").body_str)
  (1..1).each do |number|
    name = noke.xpath("//table[#{number}][@class='table_gl']//div[@class='td_top_text']").text
    genre = noke.xpath("//table[#{number}][@class='table_gl']//tr[@class='td_top_color']//td[1]//p").text
    author = noke.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//a[2]//strong").text
    description = noke.xpath("//table[#{number}][@class='table_gl']//tr[3][@class='td_center_color']//td/p").text
    publishing = noke.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//p/text()").text
    general = publishing.delete("\t\r").strip!.squeeze("\n").split("\n")

    global << [
       name,
       genre,
       author,
       general[0],
       general[1],
       general[2],
       general[3],
       general[4],
       general[5],
       description
    ]
  end
end
print(global)

