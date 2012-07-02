configatron.configure_from_yaml "#{Rails.root}/config/config.yml", :hash => Rails.env
configatron.configure_from_yaml "#{Rails.root}/config/color.yml", :hash => Rails.env
