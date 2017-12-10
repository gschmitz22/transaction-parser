class Account < ApplicationRecord
  has_many :transactions

  def self.find_by_name(name)
    accounts = Account.all
    accounts.each do |account|
      return Account.find_by_id(account.id) if account.name == name
    end
    raise ArgumentError.new('Account not found')
  end
end
