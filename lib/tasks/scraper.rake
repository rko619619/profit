namespace :scraper do
  desc "TODO"
  task scraper: :environment do
    name = Download.new
    inf = name.information
    inf.each do |attr|
      id = Category.find_by(name: attr[:category_id])
      book = Book.new(name: attr[:name], category_id: id)
      puts(book.save)
    end
  end
end
