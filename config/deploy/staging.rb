set :user, "admin"
set :password, "sdf$#sdn23"
set :port, 8389
set :rails_env, "staging"
set :port, 8389
set :branch,    "master"
set :db_user,        "root"
set :db_password,    "root"
set :url,            "staging.eco-incubators.com"
set :db_adapter,     "mysql2"
set :db_encoding,    "utf8"
set :remote_db_name, "ecoincubators_staging"
set :deploy_to, "/var/www/apps/#{application}"
role :app,    "174.143.242.132" 
role :worker, "174.143.242.132" 
role :db,     "174.143.242.132", :primary => true #{}"173.255.221.85", :primary => true
role :web,    "174.143.242.132"

# server "echochicks.com", :app, :web, :db, :primary => true
# set :deploy_to, "/var/www/echochicks"
