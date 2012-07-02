Capistrano::Configuration.instance.load do
  # These are set to the same structure in shared <=> current
  set :standard_symlinks, %w(tmp log config/database.yml) unless exists?(:standard_symlinks)


  #############################################################
  # Symlinks for Static Files
  #############################################################

  set :custom_symlinks, {
    'bundle'               => 'vendor/bundle',
    'pids'                 => 'tmp/pids',
    'public/system'        =>  'system',
  }  unless exists?(:custom_symlinks)


  namespace :symlinks do
    desc "Make all the symlinks in a single run"
    task :make, :roles => :app, :except => { :no_release => true } do
      commands = standard_symlinks.map do |path|
        "rm -rf #{current_path}/#{path} && \
         ln -s #{shared_path}/#{path} #{current_path}/#{path}"
      end

      commands += custom_symlinks.map do |from, to|
        "rm -rf #{current_path}/#{to} && \
         ln -s #{shared_path}/#{from} #{current_path}/#{to}"
      end

      run <<-CMD
      cd #{current_path} && #{commands.join(" && ")}
      CMD
    end
  end
end
