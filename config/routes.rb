Rails.application.routes.draw do
   # Swagger UI
   mount Rswag::Ui::Engine => '/api-docs'
   # API docs endpoint
   mount Rswag::Api::Engine => '/api-docs.json'

   devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, defaults: { format: :json }
  
  resources :teams do
    resources :memberships, controller: 'team_memberships', only: %i[index create destroy]
  end
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
