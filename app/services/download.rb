require 'curb'
require 'nokogiri'
require_relative 'scraper'

class Download
  URL = 'http://loveread.ec/index_book.php?id_genre=1&p='.freeze
  PAGE_COUNT = 1
  PAGE_BOOK = 6

  def initialize
    @threads = []
    @books = []
    @mutex = Mutex.new
  end

  def information
    (1..PAGE_COUNT).each do |page|
      @threads << Thread.new(page) do
        doc = Nokogiri::HTML(Curl::Easy.http_get("#{URL}#{page}").body_str)
        get_information_page(doc)
      end
      @threads.each(&:join)
    end
    @books
  end

  def get_information_page(doc)
    (1..PAGE_BOOK).each do |num|
      book = Scraper.new(doc, num).information
      @mutex.synchronize do
        @books << book
      end
    end
    @books
  end
end

name = Download.new
inf = name.information
print(inf)