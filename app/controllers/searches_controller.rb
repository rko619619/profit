# frozen_string_literal: true

class SearchesController < ApplicationController
  def index
    @books = Book.search(params[:query], fields: %i[name author isbn])
  end
end
