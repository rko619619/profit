class BooksController < ApplicationController
  def index
    @books = Book.paginate(page: params[:page], per_page: 6)

    respond_to do |format|
      format.html
      format.js
    end

  end

  def show
    @book = Book.find(params[:id])
    @category = Category.find(@book.category_id)
  end
end
