class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.integer :total_loyalty_points, default: 0
      t.datetime :date_of_birth
      t.integer :tier, default: 0
      t.string :country

      t.timestamps
    end
  end
end
