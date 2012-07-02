namespace :db do
  namespace :data do
    desc "Adding default users"
    task :create_admin_user => :environment do
      User.destroy_all
      User.find_or_create_by_email(:id => 1, :name => "James Wachira",  :email => "jamomathenge@gmail.com", :password => "1qaz2wsx", :password_confirmation => "1qaz2wsx", :confirmed_at => Time.now)
      User.find_or_create_by_email(:id => 2, :name => "Martin Kaberia", :email => "martinkiraikabe@gmail.com", :password => "1qaz2wsx", :password_confirmation => "1qaz2wsx", :confirmed_at => Time.now)
      User.find_or_create_by_email(:id => 3, :name => "Hoppa Otieno",   :email => " hopper.omondi@facebook.com", :password => "1qaz2wsx", :password_confirmation => "1qaz2wsx", :confirmed_at => Time.now)
      user.add_role :admin
      puts "======Admin user created======"
    end
  end
end
