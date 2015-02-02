RailsApp::Application.routes.draw do
  root 'static_pages#index'
  resources :stock, except: [:destroy], defaults: {format: "json"}
  namespace :stock, defaults: {format: "json"} do
    resource :search, only:[:create]
  end
end
