class BalanceConfirmController < ApplicationController
  def top
  end

  def show
    @year_month = params[:year_month] + "-01"
		@incomes = Income.order(created_at: :asc)
		@expenses = Expense.order(created_at: :asc)

		#収入計算
		@income_values =IncomeValue.where(year_month: @year_month)
		@income_value_total = cal_income_total(@income_values)
		@income_values.each do |income_value|
			@income_value_total += income_value.value
		end

		#支出計算
		@expense_values = ExpenseValue.where(year_month: @year_month)
		@expense_value_total = cal_expense_total(@expense_values)
		@expense_values.each do |expense_value|
			@expense_value_total += expense_value.value
    end

    #収支差
		@balance_difference = @income_value_total - @expense_value_total
	end

	def show_year
		year = params[:year]
		@year = year
		months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12" ]
		year_months = months.map do |month|
			year+"-"+month+"-01"
		end

		puts year_months

		#年度の収入配列を作成
		i=0
		total = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
		year_months.each do |year_month|
			income_values = IncomeValue.where(year_month: year_month)
			if income_values.present?
				total[i] = cal_income_total(income_values)
			end
			i += 1
		end
		@income_value_totals = total

		#年度の支出配列を作成
		i=0
		total = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
		year_months.each do |year_month|
			expense_values = ExpenseValue.where(year_month: year_month)
			if expense_values.present?
				total[i] = cal_expense_total(expense_values)
			end
			i += 1
		end
		@expense_value_totals = total

		#年度の収支結果を計算
		@balance_differences = [nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil]
		0.upto(11) do |i|
			if @income_value_totals[i].present? && @expense_value_totals[i].present?
				@balance_differences[i] = @income_value_totals[i] - @expense_value_totals[i]
			end
		end
	end

	#収入トータル計算
	def cal_income_total(income_values)
		income_value_total = 0 #収入合計
		income_values.each do |income_value|
			income_value_total += income_value.value
		end
		income_value_total
	end

	#支出トータル計算
	def cal_expense_total(expense_values)
		expense_value_total = 0 #支出合計
		expense_values.each do |expense_value|
			expense_value_total += expense_value.value
		end
		expense_value_total
	end
end
