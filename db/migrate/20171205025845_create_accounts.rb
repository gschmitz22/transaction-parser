class CreateAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :accounts do |t|
      t.string :name, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false

      t.timestamps
    end
  end
end
