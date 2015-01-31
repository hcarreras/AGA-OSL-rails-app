RailsApp::Application.routes.draw do
  root 'static_pages#index'
  resources :stock, except: [:destroy]
  namespace :stock do
    resource :search, only:[:create]
  end
end
