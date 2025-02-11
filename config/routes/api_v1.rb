namespace :api do
  namespace :v1 do
    draw 'api/v1/companies'
    namespace :employees do
      resource :session, only: %i[create show] do
        post :refresh, on: :collection
        post :update_password, on: :member
      end

      resource :profile, only: %i[update] do
        patch :update_email
        post  :verify_email_update
      end
    end

    resources :actions, only: %i[index]
    resources :assessments, only: %i[create show update index] do
      collection do
        post :trigger_tis_api
        get :activities, to: 'assessments/activities#index'
      end

      scope module: :assessments do
        resources :triggers, only: [] do
          post :evaluate_trigger, on: :member
          post :evaluate_triggers, on: :collection
        end

        resources :action_results, only: %i[update]
        resources :activities, only: %i[index show]
      end
    end

    resources :activities, only: %i[create show index]
    resources :uploads, only: :create do
      get 'download/:key', on: :collection, action: :download, as: 'download'
    end

    scope module: :activities do
      resources :activities, only: [] do
        resources :triggers, only: %i[create show index destroy]
      end
    end

    scope module: :questionnaires do
      resources :questionnaires, only: %i[] do
        resources :triggers, only: %i[index]
      end
    end

    namespace :company_employees do
      resource :invitation, only: %i[show update create]
      resources :invitations, only: [] do
        post :resend_invite, on: :member
        post :bulk_invite, on: :collection
      end
    end

    resources :company_employees, only: %i[update index]
    resources :associated_activities, only: %i[index create show]
  end
end
