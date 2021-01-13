class SearchesController < ApplicationController
  def index
    @books = Book.search(params[:query], fields: [:name, :author, :language])
  end
end