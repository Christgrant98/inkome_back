Rails.application.routes.draw do
  
  resources :adverts, only: [:index, :create]
  resources :users, only: [:create, :update]
  post '/auth/login', to: 'authentication#login'
  post '/adverts/:advert_id/favorites', to: 'advert_favorites#create'
  delete '/adverts/:advert_id/favorites', to: 'advert_favorites#destroy'
  get '/favorites', to: 'adverts#favorites'

end
