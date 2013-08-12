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

#default_run_options[:pty] = true

set :use_sudo, false

load 'deploy/assets'