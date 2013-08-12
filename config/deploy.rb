require 'capistrano/ext/multistage'
require "rvm/capistrano"
require "bundler/capistrano"

set :application, "loadmaster_logger"
set :repository,  "set your repository location here"

set :scm, :git
set :repository, "git@github.com:AreWeThereYeti/loadmaster_logger.git"
set :scm_passphrase, ""

set :user, "sprotte"

set :stages, ["staging", "production"]
set :default_stage, "staging"

default_run_options[:pty] = true

set :use_sudo, false

load 'deploy/assets'

set :rails_env, "production"

# Passenger
namespace :deploy do
  task :start do ; end
  
  task :start_rails do
    puts '!starting app!'
    run "rails s -e production"
  end
  
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

end

after "deploy", "deploy:start_rails" 