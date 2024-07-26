Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users,
        singular: :user,
        path_names: {
          sign_in: 'login',
          sign_out: 'logout',
          confirmation: 'verification'
        },
        controllers: {
          sessions: 'api/v1/users/sessions',
        }

        resources :msos do
          resources :companies do
            resources :job_routes do
              resources :job_route_notes
            end
          end

          resources :areas
          resources :inventory_types
          resources :inventories
        end

      resources :users do
        collection do
          get 'me'
        end
      end
    end
  end


  get "up" => "rails/health#show", as: :rails_health_check
end
