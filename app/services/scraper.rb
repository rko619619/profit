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
      name: name,
      genre: genre,
      author: author,
      description: description,
      house: publishing_house,
      isbn: publishing_isbn,
      pages: publishing_pages,
      circulation: publishing_circulation,
      size: publishing_size,
      language: publishing_language,
      image: image
    }
  end

  def name
    doc.xpath("//table[#{num}][@class='table_gl']//div[@class='td_top_text']").text
  end

  def genre
    doc.xpath("//table[#{num}][@class='table_gl']//tr[@class='td_top_color']//td[1]//p").text
  end

  def author
    doc.xpath("//table[#{num}][@class='table_gl']//td[@class='span_str']//a[2]//strong").text
  end

  def description
    doc.xpath("//table[#{num}][@class='table_gl']//tr[3][@class='td_center_color']//td/p").text
  end

  def publishing_house
    publishing = doc.xpath("//table[#{num}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")[0]
  end

  def publishing_isbn
    publishing = doc.xpath("//table[#{num}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")[1]
  end

  def publishing_pages
    publishing = doc.xpath("//table[#{num}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")[2]
  end

  def publishing_circulation
    publishing = doc.xpath("//table[#{num}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")[3]
  end

  def publishing_size
    publishing = doc.xpath("//table[#{num}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")[4]
  end

  def publishing_language
    publishing = doc.xpath("//table[#{num}][@class='table_gl']//td[@class='span_str']//p/text()").text
    publishing.delete("\t\r").strip!.squeeze("\n").split("\n")[5]
  end

  def image
    'http://loveread.ec/' + doc.xpath("//table[#{num}][@class='table_gl']//img[@class='margin-right_8']").attr('src')
  end
end

