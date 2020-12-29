namespace :scraper do
  desc "TODO"
  task scraper: :environment do
    name = Download.new
    @books = name.information
    @books.each do |book|
      book[:category_id] = Category.find_by(name: book[:category_id]).id
    end
    @books
    Book.import(@books)
  end
end