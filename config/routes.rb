Rails.application.routes.draw do
  get "/up", to: "health#show"

  root to: "campuses#index"

  jsonapi_resources :campuses
  jsonapi_resources :terms
  jsonapi_resources :subjects
  jsonapi_resources :courses
  jsonapi_resources :fees
end
