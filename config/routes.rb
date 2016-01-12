Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/google', as: :login
  get '/auth/google/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get "dashboard", to: "dashboard#show"
  match 'seattle/crime' => 'seattle#crime', :via => :get

  namespace :api do
    namespace :v1 do
      resources :crimes, only: [:index], defaults: {format: 'json'}
    end
  end
end
