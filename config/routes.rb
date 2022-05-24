Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # here we go
  get '/projects/:id', to: 'projects#show'

  get '/contestants', to: 'contestants#index'
end
