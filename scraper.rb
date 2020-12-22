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
    [
      name(@doc, @num),
      genre(@doc, @num),
      author(@doc, @num),
      description(@doc, @num),
      publishing(@doc, @num),
      image(@doc, @num)
    ]
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

  def publishing(document, number)
    publishing = document.xpath("//table[#{number}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")
  end

  def image(document, number)
    'http://loveread.ec/' + document.xpath("//table[#{number}][@class='table_gl']//img[@class='margin-right_8']").attr('src')
  end
end

class Books
  attr_reader :books, :threads
  URL = 'http://loveread.ec/index_book.php?id_genre=1&p='.freeze

  def initialize
    @threads = []
    @books = []
  end

  def get_information
    (1..10).each do |page|
      @threads << Thread.new(page) do
        doc = Nokogiri::HTML(Curl::Easy.http_get("#{URL}#{page}").body_str)
        get_information_page(doc)
      end
      @threads.each(&:join)
    end
    @books
  end

  def get_information_page(doc)
    (1..6).each do |num|
      book = Scraper.new(doc, num).information
      @books << Writer.new(book).write
    end
    @books
  end
end

class Writer
  def initialize(book)
    @book = book
    @mutex = Mutex.new
  end

  def write
    @mutex.synchronize do
      [
        @book[0], @book[1], @book[2],
        @book[4][0], @book[4][1],
        @book[4][2], @book[4][3],
        @book[4][4], @book[4][5],
        @book[3], @book[5]
      ]
    end
  end
end

name = Books.new
inf = name.get_information
print(inf)
