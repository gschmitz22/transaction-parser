# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

category_list = [
  ['Rent & Utilities', 'The monthly check for rent and water, sewer etc.' ],
  ['Tithing', 'Donations'],
  ['Restaurants', 'A catch all for all times eating out'],
  ['Gas', 'Fuel for travel'],
  ['Income', 'All money that is coming in'],
  ['General Bills', 'Other bills like insurance, electric, internet etc.'],
  ['Groceries', 'Food for cooking at home'],
  ['Fun', 'Unneccesary spending or flexible spending'],
]

accounts = [
  'CapFed Checking',
  'CapFed Savings',
  'Discover It',
  'Trek Card',
  'Intrust Checking',
  'Intrust Savings',
]

category_list.each do |name, description|
  Category.create(name: name, description: description)
end

accounts.each do |name|
  Account.create(name: name, amount: 0)
end
