class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.date 'date'
      t.string 'description'
      t.belongs_to :category, index: true
      t.numeric 'amount'
    end
  end
end
