namespace :api do
  namespace :v1 do
    namespace :employees do
      resource :session, only: %i[create show] do
        post :refresh, on: :collection
      end
    end

    resources :actions, only: %i[index]
    resources :companies, only: %i[index create]
    resources :assessments, only: %i[create show update index] do
      scope module: :assessments do
        resources :triggers, only: [] do
          post :evaluate_trigger, on: :member
          post :evaluate_triggers, on: :collection
        end
      end
    end

    resources :activities, only: %i[create show index]
    resources :uploads, only: :create

    scope module: :activities do
      resources :activities, only: [] do
        resources :triggers, only: %i[create show index]
      end
    end

    scope module: :questionnaires do
      resources :questionnaires, only: %i[] do
        resources :triggers, only: %i[index]
      end
    end
  end
end
