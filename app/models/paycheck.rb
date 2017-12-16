class Paycheck < ApplicationRecord

  def net_pay
    gross_pay - taxes - roth_401k - tradition_401k - aspp - deductions
  end

  def self.find_by_month(month)
    Paycheck.where('extract(month from date) = ?', month).all
  end
end
