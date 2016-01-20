Rails.application.routes.draw do
  root 'welcome#index'

  get '/auth/google', as: :login
  get '/auth/google/callback', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get "dashboard", to: "dashboard#show"
  match 'seattle/crime' => 'seattle#crime', :via => :get

  resources :users, only: [:update, :destroy]

  resources :seattle, only: [:bike_thefts] do
    get :bike_thefts, on: :collection
  end

  resources :bikes, only: [:create, :destroy] do
    post :missing, on: :member
  end

end
