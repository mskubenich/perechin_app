$:.unshift(File.expand_path('./lib', ENV['rvm_path']))
require "rvm/capistrano"
set :rvm_ruby_string, '1.9.3'

require 'capistrano-deploy'
use_recipes :git, :rails, :bundle, :unicorn

server '31.131.16.100', :web, :app, :db, :primary => true
set :user, 'perechin'
set :deploy_to, '/home/perechin/perechin_app'
set :repository, 'git@github.com:mskubenich/perechin_app.git'

after 'deploy:update', 'bundle:install'
after 'deploy:restart', 'unicorn:stop'