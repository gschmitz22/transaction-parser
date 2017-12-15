class Category < ApplicationRecord
  has_many :transactions

  def self.find_by_name(name)
    categories = Category.all
    categories.each do |category|
      return Category.find_by_id(category.id) if category.name == name
    end
    raise ArgumentError, 'Category not found'
  end

  def self.total_up_transactions_by_month(month)
    sums = {}
    Category.all.each do |cat|
      sums[cat[:name]] = 0;
    end
    transactions = if month.nil?
                     Transaction.all
                   else
                     Transaction.transaction_by_month(month)
                   end

    transactions.each do |transaction|
      sums[transaction.category.name] += transaction.amount
    end

    combine(sums)
  end

  def self.combine(sums)
    result = []
    Category.all.each do |cat|
      result.push(name: cat[:name], amount: sums[cat[:name]].to_f)
    end

    result
  end
end
