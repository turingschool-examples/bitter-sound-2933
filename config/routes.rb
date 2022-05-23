Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/projects/:id', to: 'projects#show'

  post '/projects/:id/contestants', to: 'projects_contestants#create'

  get '/contestants', to: 'contestants#index'
end
