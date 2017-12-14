class Account < ApplicationRecord
  has_many :transactions
  validates_uniqueness_of :name

  def self.find_by_name(name)
    accounts = Account.all
    accounts.each do |account|
      return Account.find_by_id(account.id) if account.name == name
    end
    raise ArgumentError, 'Account not found'
  end
end
