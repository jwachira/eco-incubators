set :user, "admin"
set :password, "sdf$#sdn23"
set :port, 8389
set :rails_env, "staging"
set :port, 8389
set :branch,    "master"
set :db_user,        "root"
set :db_password,    "root"
set :url,            "echochicks.com"
set :db_adapter,     "mysql2"
set :db_encoding,    "utf8"
set :remote_db_name, "echochicks_staging"
set :deploy_to, "/var/www/apps/#{application}/staging"
role :app,    "174.143.242.132" #{}"173.255.221.85"
role :worker, "174.143.242.132" #{}"173.255.221.85"
role :db,     "174.143.242.132", :primary => true #{}"173.255.221.85", :primary => true
role :web,    "echochicks.com"


