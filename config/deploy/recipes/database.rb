require 'erb'

Capistrano::Configuration.instance.load do
  namespace :db do
    namespace :mysql do

      desc 'Download Translation keys sql dumps'
      task :download_translation_keys_sql, :roles => :db, :only => { :primary => true } do
      run "cd #{deploy_to}/#{current_dir} && " +
       "rake RAILS_ENV=#{rails_env} db:download_translations_tables --trace"
      end

      desc 'Downloads db/production_data.sql from the remote production environment to your local machine'
      task :ftp, :roles => :db, :only => { :primary => true } do
        execute_on_servers(options) do |servers|
          self.sessions[servers.first].sftp.connect do |tsftp|
            tsftp.download!("#{deploy_to}/#{current_dir}/db/#{rails_env}_data.sql", "db/#{rails_env}_data.sql")
          end
        end
      end

      desc 'Cleans up data dump file'
      task :cleanup , :roles => :db, :only => { :primary => true } do
        execute_on_servers(options) do |servers|
          self.sessions[servers.first].sftp.connect do |tsftp|
            tsftp.remove! "#{deploy_to}/#{current_dir}/db/#{rails_env}_data.sql"
          end
        end
      end
      
      desc 'Dumps, downloads and then cleans up the translation keys sql dump'
      task :download_translation_keys do
        download_translation_keys_sql
        ftp
        cleanup
      end
      

      desc 'Dumps, downloads and then cleans up the production data dump'
      task :download do
        translation_dumps
        ftp
        cleanup
      end

      desc "Clone the production database into your development one"
      task :dupe do
        download
        `rake REMOTE_ENV=#{rails_env} db:restore`
        cloner = `whoami`.strip
        campfire_notify "#{cloner} just cloned the #{rails_env} database"
      end


      desc "Create MySQL database and user for this rails_env using prompted values"
      task :setup, :roles => :db, :only => { :primary => true } do
        prepare_for_db_command

        sql = <<-SQL
        CREATE DATABASE #{db_name};
        GRANT ALL PRIVILEGES ON #{db_name}.* TO #{db_user}@localhost IDENTIFIED BY '#{db_password}';
        SQL

        run "mysql --user=#{db_user} -p --execute=\"#{sql}\"" do |channel, stream, data|
          if data =~ /^Enter password:/
            pass = Capistrano::CLI.password_prompt "Enter database password for '#{db_user}':"
            channel.send_data "#{pass}\n"
          end
        end
      end

      # Sets database variables from remote database.yaml
      def prepare_from_yaml
        set(:db_file) { "#{application}-dump.sql.bz2" }
        set(:db_remote_file) { "#{shared_path}/backup/#{db_file}" }
        set(:db_local_file)  { "tmp/#{db_file}" }
        set(:db_user) { db_config[rails_env]["username"] }
        set(:db_password) { db_config[rails_env]["password"] }
        set(:db_host) { db_config[rails_env]["host"] }
        set(:db_name) { db_config[rails_env]["database"] }
      end

      def db_config
        @db_config ||= fetch_db_config
      end

      def fetch_db_config
        require 'yaml'
        file = capture "cat #{shared_path}/config/database.yml"
        db_config = YAML.load(file)
      end
    end

    desc "Create database.yml in shared path with settings for current stage and test env"
    task :create_yaml do
      set(:db_user) { Capistrano::CLI.ui.ask "Enter #{rails_env} database username:" }
      set(:db_password) { Capistrano::CLI.password_prompt "Enter #{rails_env} database password:" }

      db_config = ERB.new <<-EOF
      base: &base
      adapter: #{db_adapter}
        encoding: #{db_encoding}
        username: #{db_user}
        password: #{db_password}

        #{rails_env}:
        database: #{application}_#{rails_env}
        <<: *base

      test:
        database: #{application}_test
        <<: *base
      EOF

      put db_config.result, "#{shared_path}/config/database.yml"
    end
  end

  def prepare_for_db_command
    set :db_name, "#{application}_#{rails_env}"
    set(:db_admin_user) { Capistrano::CLI.ui.ask "Username with priviledged database access (to create db):" }
    set(:db_user) { Capistrano::CLI.ui.ask "Enter #{rails_env} database username:" }
    set(:db_password) { Capistrano::CLI.password_prompt "Enter #{rails_env} database password:" }
  end

  desc "Populates the database with seed data"
  task :seed do
    Capistrano::CLI.ui.say "Populating the database..."
    run "cd #{current_path}; rake RAILS_ENV=#{variables[:rails_env]} db:seed"
  end

  after "deploy:setup" do
    db.create_yaml if Capistrano::CLI.ui.agree("Create database.yml in app's shared path? [Yn]")
    'db:mysql:setup'
  end

  after "deploy:create_yaml" do
    'db:mysql:setup'
  end
end
