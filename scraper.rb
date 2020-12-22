require 'curb'
require 'nokogiri'
require 'csv'
require 'time'

time1 = Time.now
url_category = "http://loveread.ec/index_book.php?id_genre=1&p="
global = []
threads = []
mutex = Mutex.new
(1..1550).each do |page|
  threads << Thread.new(page) do |page_html|
    noke = Nokogiri::HTML(Curl::Easy.http_get("#{url_category.to_s}#{page_html}").body_str)
    (1..6).each do |number|
      name = noke.xpath("//table[#{number}][@class='table_gl']//div[@class='td_top_text']").text
      genre = noke.xpath("//table[#{number}][@class='table_gl']//tr[@class='td_top_color']//td[1]//p").text
      author = noke.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//a[2]//strong").text
      description = noke.xpath("//table[#{number}][@class='table_gl']//tr[3][@class='td_center_color']//td/p").text
      publishing = noke.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//p/text()").text
      general = publishing.delete("\t\r").strip!.squeeze("\n").split("\n")
      image = 'http://loveread.ec/' + noke.xpath("//table[#{number}][@class='table_gl']//img[@class='margin-right_8']").attr('src')
      mutex.synchronize{
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
            description,
            image
        ]
      }
    end
  end
  threads.each { |aThread| aThread.join }
end

puts(global)
time2 = Time.now
puts(time2 - time1)
