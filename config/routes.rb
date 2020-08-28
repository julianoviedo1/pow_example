Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  get '/places',to: "places#bulk_create"

end
