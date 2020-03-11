class Form::ExpenseValue < ExpenseValue
	REGISTRABLE_ATTRIBUTES = %i(expense_id year_month value description)
	attr_accessor :expense_id
	attr_accessor :year_month
	attr_accessor :value
	attr_accessor :description
end
