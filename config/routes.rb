RailsApp::Application.routes.draw do
  get 'oauth2callback' => 'stock#set_google_drive_token' # user return to this after login
  root 'static_pages#index'
  resources :stock
end
