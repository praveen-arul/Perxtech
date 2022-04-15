class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.integer :amount, default: 0
      t.integer :points_generated, default: 0
      t.string :payment_mode

      t.timestamps
    end
  end
end
