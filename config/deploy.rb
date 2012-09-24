set :application, 'ionic'
set :copy_exclude, [".git"]
set :stages, %w(beta staging production)
set :default_stage, "staging"

require "bundler"
Bundler.setup(:default, :deployment)

require 'capistrano/ext/multistage'
require "bundler/capistrano"
# thinking sphinx cap tasks
require File.dirname(__FILE__) + '/deploy/san_juan'
require File.join(File.dirname(__FILE__), "/deploy/recipes")

set :repository, "git@github.com:jwachira/eco-incubators.git"
set :keep_releases, 4
set :scm, :git
set :deploy_via,       :remote_cache

set :github_username, `git config --global -l | grep github.user`.split('=')[1]
set :bundle_flags,    ""
san_juan.role :worker, %w(resque)

ssh_options[:forward_agent] = true
default_run_options[:pty]   = true

set(:latest_release)  { fetch(:current_path) }
set(:release_path)    { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

# check redis
namespace :resque do
  desc "Push a test job into Resque from each application server"
  task :test_enqueue, :roles => [ :app ] do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} rake resque:test"
  end
end

set :shared_dirs, %w(config uploads backup bundle tmp db) unless exists?(:shared_dirs)

namespace :app do
  task :setup, :roles => :app do
    commands = shared_dirs.map do |path|
      "if [ ! -d '#{path}' ]; then mkdir -p #{path}; fi;"
    end
    run "cd #{shared_path}; #{commands.join(' ')}"
  end
end

namespace :data do
  desc "Update Currency Conversation rates"
  task :default_data, :role => :app do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} rake db:data:create_admin_user --trace"
    run "cd #{current_path} && RAILS_ENV=#{rails_env} rake db:data:create_default_categories --trace"
  end
end



