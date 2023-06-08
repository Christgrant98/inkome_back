Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  resources :adverts, only: [:index, :create]
  resources :users, only: [:create, :update]
  post '/auth/login', to: 'authentication#login'
  post '/adverts/:advert_id/favorites', to: 'advert_favorites#create'
  delete '/adverts/:advert_id/favorites', to: 'advert_favorites#destroy'

    #PRIMERO - ESTABLECER LA MISMA RUTA ASIGNADA EN ROUTES-
    #SEGUNGO - ESTABLECER EL METODO (POST) EN EL POSTMAN-
    #TERCERO - ESTABLECER KEY- CONTENT-TYPE VALUE- APPPLICATION/JSON
    #CUARTO - BODY- RAW - JSON 
    #QUINTO - PASAR ENTRE {} - PARAMS ESTABLECIDOS "password" : "canguro98", "email" : "canguro@admin.com" <- EN ESTE CASO
    # BONUS TO CEHCK -require_relative "lib/json_web_token" 
    #SEXTO SEND 
    #:: <- SIGNIFICA QUE EL ELEMENTO QUE SE BUSCA SE ESNCUENTRA POR FUERA

end
