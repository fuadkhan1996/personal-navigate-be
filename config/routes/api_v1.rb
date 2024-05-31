namespace :api do
  namespace :v1 do
    namespace :employees do
      resource :session, only: %i[create show]
    end

    resources :actions, only: %i[index]
    scope module: :questionnaires do
      resources :questionnaires, only: [] do
        resources :actions, only: %i[create index]
      end
    end

    resources :accounts, only: %i[index]
    resources :assessments, only: %i[create show]
    resources :activities, only: %i[create show]
  end
end
