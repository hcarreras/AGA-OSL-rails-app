RailsApp::Application.routes.draw do
  root 'static_pages#index'
  resources :stock, except: [:destroy]
end
