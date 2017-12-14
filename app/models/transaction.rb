class Transaction < ApplicationRecord
  require 'csv'

  belongs_to :account
  belongs_to :category

  validates_uniqueness_of :date, scope: %i[description amount]

  def self.initialize
    @data = []
  end

  def self.import(file)
    initialize
    errors = []
    CSV.foreach(file.path) do |row|
      @data.push(row)
    end

    prepare_data

    @data.each do |date, description, amount, category, account|
      begin
        Transaction.create(date: Date.strptime(date, '%m/%d/%Y'),
                           description: description,
                           amount: amount,
                           category: Category.find_by_name(category),
                           account: Account.find_by_name(account))
      rescue ArgumentError
        errors.push [date, description, amount, category, amount]
      end
    end

    unsaved_file(@data[0], errors)
  end

  def self.remove_column(names)
    names.each do |name|
      location = @data[0].index(name)
      @data.each do |row|
        row.delete_at(location)
      end
    end
  end

  def self.convert_to_category(new_category, categories)
    cat_index = @data[0].index('Category')
    categories.each do |category|
      @data.each do |row|
        row[cat_index] = new_category if row[cat_index] == category
      end
    end
  end

  def self.convert_to_account(new_account, account)
    account_index = @data[0].index('Account Name')
    @data.each do |row|
      row[account_index] = new_account if row[account_index] == account
    end
  end

  def self.unsaved_file(headers, errors)
    CSV.open('notAdded.csv', 'wb') do |csv|
      csv << headers
      errors.each do |row|
        csv << row
      end
    end
  end

  def self.prepare_data
    remove_column(['Notes', 'Labels', 'Original Description', 'Transaction Type'])
    convert_to_category('Bill', ['Auto Insurance', 'Television', 'Hair', 'Auto Payment'])
    convert_to_category('Tithing', ['Charity'])
    convert_to_category('Restaurants', ['Fast Food', 'Food & Dining', 'Alcohol & Bars'])
    convert_to_category('Gas', ['Gas & Fuel'])
    convert_to_category('Rent & Utilities', ['Mortgage & Rent'])
    convert_to_account('Discover It', 'Discover it Card')
    convert_to_account('CapFed Checking', 'Checking')
    convert_to_account('CapFed Savings', 'Savings')
    # convert_to_account('Trek Card', '')
    convert_to_account('Intrust Checking', 'Checking Account')
  end

  def self.transaction_by_month(month)
    Transaction.where('extract(month from date) = ?', month).all
  end
end
