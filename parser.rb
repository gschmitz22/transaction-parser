require 'csv'
require 'pp'

data = []

CSV.foreach('transactions.csv') do |row|
  data.push(row)
end

def remove_column(array, names)
  names.each do |name|
    index = array[0].index(name)
    array.each do |row|
      row.delete_at(index)
    end
  end
  array
end

def remove_category(array, names)
  names.each do |name|
    category = array[0].index('Category')
    description = array[0].index('Description')
    array.delete_if do |row|
      row[category] == name && !(row[description] == "Venmo" && !(row[description] == "Line Transfer Acc"))
    end
  end
  array
end

def move_amount_to_end(array)
  amount = array[0].index('Amount')
  array.each do |row|
    row.push(row[amount])
    row.delete_at(amount)
  end
end

def convert_amounts_to_numbers(array)
  amount = array[0].index('Amount')
  array.each do |row|
    row[amount] = row[amount].to_i unless row[amount] == 'Amount'
  end
end

def convert_to_category(array, new_category, categories)
  cat_index = array[0].index('Category')
  categories.each do |category|
    array.each do |row|
      row[cat_index] = new_category if row[cat_index] == category
    end
  end
  array
end

data = remove_column(data, ['Notes', 'Labels', 'Original Description', 'Transaction Type', 'Account Name'])
data = remove_category(data, ['Transfer', 'Paycheck', 'Credit Card Payment'])
data = move_amount_to_end(data)
data = convert_amounts_to_numbers(data)
data = convert_to_category(data, 'Bill', ['Auto Insurance', 'Mortgage & Rent', 'Television', 'Hair', 'Auto Payment'])
data = convert_to_category(data, 'Tithing', ['Charity'])
data = convert_to_category(data, 'Restaurant', ['Restaurants', 'Fast Food', 'Food & Dining', 'Alcohol & Bars'])
data = convert_to_category(data, 'Gas', ['Gas & Fuel'])


CSV.open('parsed.csv', 'wb') do |new_row|
  data.each do |row|
    new_row << row
  end
end
