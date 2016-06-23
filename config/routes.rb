Rails.application.routes.draw do
  root to: 'campuses#index'

  jsonapi_resources :campuses
  jsonapi_resources :terms
end
