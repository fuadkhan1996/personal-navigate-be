namespace :api do
  namespace :v1 do
    namespace :employees do
      resource :session, only: %i[create show]
    end

    resources :actions, only: %i[index]
    resources :accounts, only: %i[index]
    resources :assessments, only: %i[create show]
    resources :activities, only: %i[create show index]

    scope module: :activities do
      resources :activities, only: [] do
        resources :triggers, only: %i[create]
      end
    end
  end
end
