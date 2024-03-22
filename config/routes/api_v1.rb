namespace :api do
  namespace :v1 do
    namespace :employees do
      resource :session, only: %i[create show]
    end
  end
end
