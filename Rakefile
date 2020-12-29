# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"
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
Rails.application.load_tasks
