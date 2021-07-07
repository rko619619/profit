# frozen_string_literal: true

class BooksController < ApplicationController
  def index
    filter_books = BooksFilter.new(Book.all, params[:category]).call
    sorted_books = BooksSort.new(filter_books, params[:sort], params[:direction]).call
    @pagy, @books = pagy(sorted_books, items: 10)

    respond_to do |format|
      format.html
      format.json do
        render json: { entries: render_to_string(partial: 'book', formats: [:html]),
                       pagination: view_context.pagy_nav(@pagy) }
      end
    end
  end

  def show
    @book = Book.find(params[:id])
  end
end
