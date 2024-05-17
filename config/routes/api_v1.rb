namespace :api do
  namespace :v1 do
    namespace :employees do
      resource :session, only: %i[create show]
    end

    resources :action_types, only: %i[index]
    resources :actions, only: %i[create index]

    scope module: :questionnaires do
      resources :questionnaires, only: [] do
        resources :actions, only: %i[create index]
      end
    end
  end
end
