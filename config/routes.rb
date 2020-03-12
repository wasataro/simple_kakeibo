Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "top#index"
  post "income_values/new(/:name)", to: "income_values#new"
  post "expense_values/new(/:name)", to: "expense_values#new"

  get "balance_confirm", to: "balance_confirm#top"
  post "balance_confirm/show(/:name)", to: "balance_confirm#show"
  post "blance_confirm/show_year(/:name)" => "balance_confirm#show_year"

  resources :incomes
  resources :expenses
  resources :income_values
  resources :expense_values
end
