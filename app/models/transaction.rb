class Transaction < ApplicationRecord
  require 'csv'

  belongs_to :account
  belongs_to :category

  def self.initialize
    @data = []
  end

  def self.import(file)
    errors = []
    CSV.foreach(file) do |row|
      @data.push(row)
    end
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

    @data.each do |date, description, amount, category, account|
      begin
        binding.pry
        Transaction.create(date: Date.strptime(date, '%m/%d/%Y'), description: description, amount: amount, category: Category.find_by_name(category), account: Account.find_by_name(account))
      rescue ArgumentError
        errors.push [date, description, amount, category, amount]
      end
    end
    unsaved_file(@data[0], errors, file)
  end

  private

  def self.remove_column(names)
    names.each do |name|
      index = @data[0].index(name)
      @data.each do |row|
        row.delete_at(index)
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

  def self.unsaved_file(headers, errors, file)
    CSV.open(file, 'wb') do |csv|
      csv << headers
      errors.each do |row|
        csv << row
      end
    end
  end
end
