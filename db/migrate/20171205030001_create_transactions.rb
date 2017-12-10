class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.date :date, null: false
      t.string :description
      t.belongs_to :account, null: false
      t.belongs_to :category, null: false
      t.decimal :amount, null: false

      t.timestamps
    end
  end
end
