class Category < ApplicationRecord
  has_many :transactions

  def self.find_by_name(name)
    categories = Category.all
    categories.each do |category|
      return Category.find_by_id(category.id) if category.name == name
    end
    raise ArgumentError.new('Category not found')
  end
end
