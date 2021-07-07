# frozen_string_literal: true

class BooksSort
  def initialize(books, sort_option, direct_option)
    @books = books
    @sort_option = sort_option
    @direct_option = direct_option
  end

  def call
    @books.order("books.#{sort} #{direction}")
  end

  private

  def sort
    if @sort_option.nil? || @sort_option == ''
      'id'
    else
      @sort_option
    end
  end

  def direction
    if @direct_option.nil? || @direct_option == ''
      'asc'
    else
      @direct_option
    end
  end
end
