Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/contestants', to: 'contestants#index'
  get '/challenges', to: 'projects#index'

  post '/projects', to: 'projects#create'
  get '/projects/:id', to: 'projects#show'

end
