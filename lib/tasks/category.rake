namespace :writer do
  desc "TODO"
  task writer: :environment do
    name = Writer.new
    name.write_base
  end
end
