require 'curb'
require 'nokogiri'
require 'csv'
require 'time'

url = 'http://loveread.ec/index_book.php?id_genre=1&p='

class Download
  def self.get_html(url, page_html)
    Nokogiri::HTML(Curl::Easy.http_get("#{url}#{page_html}").body_str)
  end

  def self.get_name(document, number)
    document.xpath("//table[#{number}][@class='table_gl']//div[@class='td_top_text']").text
  end

  def self.get_genre(document, number)
    document.xpath("//table[#{number}][@class='table_gl']//tr[@class='td_top_color']//td[1]//p").text
  end

  def self.get_author(document, number)
    document.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//a[2]//strong").text
  end

  def self.get_description(document, number)
    document.xpath("//table[#{number}][@class='table_gl']//tr[3][@class='td_center_color']//td/p").text
  end

  def self.get_publishing(document, number)
    publishing = document.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")
  end

  def self.get_image(document, number)
    'http://loveread.ec/' + document.xpath("//table[#{number}][@class='table_gl']//img[@class='margin-right_8']").attr('src')
  end
end

class Scraper
  @@threads = []
  @@mutex = Mutex.new
  @@books = []

  def self.initialize
    @books = []
  end

  def get_information(url)
    (1..2).each do |page|
      @@threads << Thread.new(page) do
        document = Download.get_html(url, page)
        Scraper.get_information_page(document)
      end
      @@threads.each(&:join)
    end
    @@books
  end

  def self.get_information_page(document)
    (1..6).each do |number|
      name = Download.get_name(document, number)
      genre = Download.get_genre(document, number)
      author = Download.get_author(document, number)
      description = Download.get_description(document, number)
      publishing = Download.get_publishing(document, number)
      image = Download.get_image(document, number)
      @@books << Scraper.write(name, genre, author, description, publishing, image)
    end
  end

  def self.write(name, genre, author, description, publishing, image)
    @@mutex.synchronize do
      [
        name, genre, author,
        publishing[0], publishing[1],
        publishing[2], publishing[3],
        publishing[4], publishing[5],
        description, image
      ]
    end
  end
end

start = Scraper.new
start.get_information(url)
