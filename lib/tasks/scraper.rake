namespace :scraper do
  desc "TODO"
  task scraper: :environment do
    name = Download.new
    inf = name.information
    inf.each do |attr|
      ids = Category.find_by(name: attr[:category_id]).id
      book = Book.new(name: attr[:name], category_id: ids)
      book.save
    end
  end
end