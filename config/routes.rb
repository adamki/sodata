Rails.application.routes.draw do
  root 'welcome#index'
  get "auth/twitter",as: :login
end
