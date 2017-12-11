Rails.application.routes.draw do
  get '/404', to: 'errors#not_found'
  get '/500', to: 'errors#internal_server_error'

  resources :books
  resources :authors
end
