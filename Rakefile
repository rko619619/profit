# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"
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
Rails.application.load_tasks
