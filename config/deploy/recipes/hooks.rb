# Common hooks for all scenarios.
Capistrano::Configuration.instance.load do
  
  # namespace :db do
  #   task :db_config, :except => { :no_release => true }, :role => :app do
  #     run "cp -f ~/database.yml #{release_path}/config/database.yml"
  #   end
  # end

  # after "deploy:finalize_update", "db:db_config"
  
  after 'deploy:setup' do
    app.setup
  end
    
  after "deploy:update_code" do
    symlinks.make
  end
    
  after "symlinks:make",                 "deploy:set_rake_path"
  after "deploy:set_rake_path",          "deploy:migrate"
  after "deploy:migrate",                "passenger:restart"
  
  before 'deploy:update_code', 'deploy:web:disable'
  after 'deploy:restart', 'deploy:web:enable'
  after "deploy:web:enable", "passenger:kickstart"
end