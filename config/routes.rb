Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/projects/:id", to: "projects#show"

  get "/projects/:id/contestants/new", to: "project_contestants#new"
  post "/projects/:id/contestants", to: "project_contestants#create"

  get "/contestants", to: "contestants#index"
end
