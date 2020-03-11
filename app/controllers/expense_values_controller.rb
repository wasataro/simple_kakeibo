class ExpenseValuesController < ApplicationController
  def index
		@expenses = Expense.order(created_at: :asc)
		@expense_values = ExpenseValue.order(year_month: :asc)
	end

	def show
		@expense_value = ExpenseValue.find(params[:id])
	end

	def new
		year_month_day = params[:year_month] + "-01"
		@year_month = year_month_day.to_date

		@expenses = Expense.order(created_at: :asc)
		@form = Form::ExpenseForm.new
	end

	def edit
		@expense_value = ExpenseValue.find(params[:id])
		@expense = Expense.find(@expense_value.expense_id)
	end

	def create
		@form = Form::ExpenseForm.new(expense_form_params)
		if @form.save
			redirect_to :expense_values, notice: "登録しました"
		else
			redirect_to :expense_values, notice: "登録に失敗しました"
		end
	end

	def expense_form_params
		params
			.require(:form_expense_form)
			.permit(expense_values_attributes: Form::ExpenseValue::REGISTRABLE_ATTRIBUTES)
	end

	def update
		@expense_value = expenseValue.find(params[:id])
		@expense_value.assign_attributes(params[:expense_value])
		if @expense_value.save
			redirect_to :expense_values, notice: "情報を更新しました"
		else
			render "edit"
		end
	end

	def destroy
		@expense_value = ExpenseValue.find(params[:id])
		@expense_value.destroy
		redirect_to :expense_values, notice: "データを削除しました。"
	end
end
