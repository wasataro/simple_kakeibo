class CreateExpenseValues < ActiveRecord::Migration[5.2]
  def change
    create_table :expense_values do |t|
      t.integer :expense_id, null: false
      t.date :year_month
      t.integer :value
      t.string :description
      t.timestamps
    end
  end
end
