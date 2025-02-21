resources :companies, only: %i[index create show] do
  scope module: :companies do
    resources :assigned_company_employees, only: %i[create destroy]
  end
end
