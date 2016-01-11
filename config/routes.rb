Rails.application.routes.draw do
  root 'welcome#index'
  get "auth/twitter", as: :login

  match 'seattle/crime' => 'seattle#crime', :via => :get
end
