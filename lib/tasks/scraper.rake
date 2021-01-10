# frozen_string_literal: true

namespace :scraper do
  desc 'TODO'
  task scraper: :environment do
    name = Download.new
    name.information
  end
end
