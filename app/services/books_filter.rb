# frozen_string_literal: true

class BooksFilter
  def initialize(books, option)
    @books = books
    @option = option
  end

  def call
    if @option.nil?
      @books
    else
      @books.joins(:category).where(category: { name: @option })
    end
  end
end
