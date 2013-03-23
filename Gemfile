source 'http://rubygems.org'

gem 'rails', '3.2.6'
gem 'paperclip'
gem 'rake', '0.8.7'
gem 'mysql2'
gem 'jquery-rails'

gem 'sass-rails',   '~> 3.2.3'
gem 'coffee-rails', '~> 3.2.1'

gem 'nokogiri'
gem 'will_paginate'
gem 'whenever'

group :production do
  gem 'uglifier'
end

namespace :deploy do
  desc "Update the crontab file"
  task :update_crontab, :roles => :app, :except => { :no_release => true } do
    run "cd #{release_path} && bundle exec whenever --update-crontab #{application}"
  end
end