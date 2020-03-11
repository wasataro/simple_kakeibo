class Form::ExpenseForm < Form::Base
	attr_accessor :expense_values

	def initialize(attributes = {})
    super attributes

		expenses = Expense.order(created_at: :asc)
		self.expense_values = expenses.map { |expense| ExpenseValue.new(expense_id: expense.id) } unless expense_values.present?
  end

	def expense_values_attributes=(attributes)
    self.expense_values = attributes.map do |_, expense_value_attributes|
      Form::ExpenseValue.new(expense_value_attributes).tap { |v| puts v}
    end

  end

	def valid?
		valid_expense_values = self.expense_values.map(&:valid?).all?
		super && valid_expense_values
	end

	def save
		return false unless valid?
		ExpenseValue.transaction {
			self.expense_values.select.each { |expense_value|
				a1 = ExpenseValue.new(:expense_id => expense_value.expense_id,
					:year_month => expense_value.year_month,
					:value => expense_value.value,
					:description => expense_value.description)
				a1.save!
			 }
		}
		true
	end

	def target_expense_values
		self.expense_values.select { |v| '*' }
	end

end
