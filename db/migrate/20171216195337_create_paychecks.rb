class CreatePaychecks < ActiveRecord::Migration[5.1]
  def change
    create_table :paychecks do |t|
      t.date :date, null: false
      t.decimal :gross_pay, precision: 10, scale: 2, null: false
      t.decimal :roth_401k, precision: 10, scale: 2, default: 0
      t.decimal :tradition_401k, precision: 10, scale: 2, default: 0
      t.decimal :aspp, precision: 10, scale: 2, default: 0
      t.decimal :deductions, precision: 10, scale: 2, default: 0
      t.decimal :taxes, precision: 10, scale: 2, default: 0
    end
  end
end
