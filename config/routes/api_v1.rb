namespace :api do
  namespace :v1 do
    namespace :employees do
      resources :sessions, only: %i[create]
    end
  end
end
