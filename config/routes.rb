Rails.application.routes.draw do
  root to: 'campuses#index'

  jsonapi_resources :campuses
  jsonapi_resources :terms
  jsonapi_resources :subjects
  jsonapi_resources :courses
end
