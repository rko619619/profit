# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require_relative "config/application"

namespace :scraper do
  desc "TODO"
  task scraper: :environment do
    name = Download.new
    name.information
  end
end

Rails.application.load_tasks
