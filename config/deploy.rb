set :application, "echochicks"
set :copy_exclude, [".git"]

require 'capistrano/ext/multistage'
set :stages, %w(staging production)
set :default_stage, "staging"

require "bundler"
Bundler.setup(:default, :deployment)

# require File.dirname(__FILE__) + '/deploy/san_juan'
# require File.join(File.dirname(__FILE__), "/deploy/recipes")

set :repository,  "https://github.com/chai2/echochicks.git"
set :keep_releases, 4
set :scm, :git
set :deploy_via,       :remote_cache
set :github_username, `git config --global -l | grep github.user`.split('=')[1]
set :bundle_flags,    ""
# san_juan.role :worker, %w(resque)

ssh_options[:forward_agent] = true
default_run_options[:pty]   = true

set(:latest_release)  { fetch(:current_path) }
set(:release_path)    { fetch(:current_path) }
set(:current_release) { fetch(:current_path) }

set(:current_revision)  { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:latest_revision)   { capture("cd #{current_path}; git rev-parse --short HEAD").strip }
set(:previous_revision) { capture("cd #{current_path}; git rev-parse --short HEAD@{1}").strip }

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
  desc "Setup default user"
  task :create_admin_user, :role => :app do
    run "cd #{current_path} && RAILS_ENV=#{rails_env} rake db:data:create_admin_user --trace"
  end
end

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end