class CreatePaychecks < ActiveRecord::Migration[5.1]
  def change
    create_table :paychecks do |t|
      t.date :date, null: false
      t.decimal :roth_401k, default: 0
      t.decimal :tradition_401k, default: 0
      t.decimal :aspp, defualt: 0
      t.decimal :deductions, default: 0
      t.decimal :taxes, default: 0
      t.decimal :net_pay, null: false
    end
  end
end
