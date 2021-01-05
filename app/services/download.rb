# frozen_string_literal: true

require 'curb'
require 'nokogiri'
require_relative 'scraper'

class Download
  URL = 'http://loveread.ec/index_book.php?id_genre=1&p='
  PAGE_COUNT = 100
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
    write_base
  end

  def get_information_page(doc)
    (1..PAGE_BOOK).each do |num|
      book = Scraper.new(doc, num).information
      @mutex.synchronize do
        @books << book
      end
    end
  end

  def write_base
    Book.import(@books)
  end
end
