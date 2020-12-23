require 'curb'
require 'nokogiri'
require 'time'

class Scraper
  attr_reader :doc, :num
  def initialize(doc, num)
    @doc = doc
    @num = num
  end

  def information
    {
      name: name(doc, num),
      genre: genre(doc, num),
      author: author(doc, num),
      description: description(doc, num),
      house: publishing_house(doc, num),
      isbn: publishing_isbn(doc, num),
      pages: publishing_pages(doc, num),
      circulation: publishing_circulation(doc, num),
      size: publishing_size(doc, num),
      image: image(doc, num)
    }
  end

  def name(document, number)
    document.xpath("//table[#{number}][@class='table_gl']//div[@class='td_top_text']").text
  end

  def genre(document, number)
    document.xpath("//table[#{number}][@class='table_gl']//tr[@class='td_top_color']//td[1]//p").text
  end

  def author(document, number)
    document.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//a[2]//strong").text
  end

  def description(document, number)
    document.xpath("//table[#{number}][@class='table_gl']//tr[3][@class='td_center_color']//td/p").text
  end

  def publishing_house(document, number)
    publishing = document.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")[0]
  end

  def publishing_isbn(document, number)
    publishing = document.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")[1]
  end

  def publishing_pages(document, number)
    publishing = document.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")[2]
  end

  def publishing_circulation(document, number)
    publishing = document.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")[3]
  end

  def publishing_size(document, number)
    publishing = document.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")[4]
  end

  def publishing_language(document, number)
    publishing = document.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")[5]
  end

  def image(document, number)
    'http://loveread.ec/' + document.xpath("//table[#{number}][@class='table_gl']//img[@class='margin-right_8']").attr('src')
  end
end

class Books
  URL = 'http://loveread.ec/index_book.php?id_genre=1&p='.freeze
  PAGE_COUNT = 1
  PAGE_BOOK = 6

  def initialize
    @threads = []
    @books = []
    @mutex = Mutex.new
  end

  def information
    PAGE_COUNT.times do |page|
      page += 1
      @threads << Thread.new(page) do
        doc = Nokogiri::HTML(Curl::Easy.http_get("#{URL}#{page}").body_str)
        get_information_page(doc)
      end
      @threads.each(&:join)
    end
    @books
  end

  def get_information_page(doc)
    PAGE_BOOK.times do |num|
      num += 1
      @mutex.synchronize do
        book = Scraper.new(doc, num).information
        @books << book
      end
    end
    @books
  end
end

name = Books.new
inf = name.information
print(inf)
