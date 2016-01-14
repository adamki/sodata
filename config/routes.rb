Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/google', as: :login
  get '/auth/google/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get "dashboard", to: "dashboard#show"
  match 'seattle/crime' => 'seattle#crime', :via => :get
  resources :seattle do
    get :get_crimes, on: :collection 
    # or you may prefer to call this route on: :member
  end

end
