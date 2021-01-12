class BooksController < ApplicationController
  def index
    @pagy, @books = pagy(Book.all, items: 10)

    respond_to do |format|
      format.html
      format.json{
        render json: { entries: render_to_string(partial: "book" , formats: [:html]), pagination: view_context.pagy_nav(@pagy)}
      }
    end

  end

  def show
    @book = Book.find(params[:id])
  end
end
