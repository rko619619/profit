# frozen_string_literal: true

module CategoriesHelper
  def categories
    Category.all
  end
end
