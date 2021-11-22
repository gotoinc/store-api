# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#

if ENV['SEED_DATA']
  $stdout.puts "Seeding database for environment: #{Rails.env}"

  # Just create a new admin user
  AdminSeeder.new.seed

  # Add default categories to app
  CategoriesSeeder.new.seed.each do |category|
    user = UserSeeder.new(role: :provider, category: category).seed
    FactoryBot.create_list(:product, rand(1..5), owner: user)
  end

  UserSeeder.new(role: :customer).seed
else
  $stdout.puts 'Pls, set `SEED_DATA=true` to start seeding process'
end
