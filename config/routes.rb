Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "top#index"
  post "income_values/new(/:name)" => "income_values#new"
  post "expense_values/new(/:name)" => "expense_values#new"

  resources :incomes
  resources :expenses
  resources :income_values
  resources :expense_values
end
