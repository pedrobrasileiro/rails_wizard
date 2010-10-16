RailsWizard::Application.routes.draw do
  root :to => 'templates#new'

  # resources :users
    
  match '/:id', :to => 'templates#show'
  match '/:id/edit', :to => 'templates#edit'
  match '/:id.rb', :to => 'templates#compile'
  
  match '/auth/:provider/callback', :to => 'sessions#create'
end
