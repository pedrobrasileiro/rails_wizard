RailsWizard::Application.routes.draw do
  root :to => 'templates#new'

  resources :templates
  resources :recipes
    
  match '/:id.rb', :to => 'templates#compile', :as => 'compile'    
  match '/:id', :to => 'templates#show', :as => 'show'
  match '/:id/edit', :to => 'templates#edit', :as => 'edit'
  match '/:id/edit/:step', :to => 'templates#edit', :as => 'step'
  
  match '/auth/:provider/callback', :to => 'sessions#create'
end
