# Bundler Integration
# http://github.com/carlhuda/bundler/blob/master/lib/bundler/capistrano.rb
require 'bundler/capistrano'
require 'erb'

# Application Settings
set :application,   "rails_wizard"
set :user,          "deploy"
set :deploy_to,     "/home/#{user}/#{application}"
set :rails_env,     "production"
set :use_sudo,      false
set :keep_releases, 5

# Git Settings
set :scm,           :git
set :branch,        "rumble10"
set :repository,    "git@github.com:railsrumble/rr10-team-2.git"
set :deploy_via,    :remote_cache

# Uses local instead of remote server keys, good for github ssh key deploy.
ssh_options[:forward_agent] = true

# Server Roles
role :web, "railswizard.org"
role :app, "railswizard.org"
role :db,  "railswizard.org", :primary => true

before "deploy:setup", :db
after "deploy:update_code", "db:symlink" 

namespace :db do
  desc "Create database yaml in shared path" 
  task :default do
    
  end

  desc "Make symlink for mongo yaml" 
  task :symlink do
    run "ln -nfs #{shared_path}/config/mongo.yml #{release_path}/config/mongo.yml" 
  end
end

# Passenger Deploy Reconfigure
namespace :deploy do
  desc "Restart passenger process"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
 
  [:start, :stop].each do |t|
    desc "#{t} does nothing for passenger"
    task t, :roles => :app do ; end
  end
end