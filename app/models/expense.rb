class Expense < ApplicationRecord
  has_many :expense_values, dependent: :destroy
end
