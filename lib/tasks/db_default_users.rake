namespace :db do
  namespace :data do
    desc "Adding default users"
    task :create_admin_user => :environment do
      user = User.find_or_create_by_email(:id => 1, :name => "James Wachira", :email => "admin@echochicks.com", :password => "1qaz2wsx", :password_confirmation => "1qaz2wsx", :confirmed_at => Time.now)
      user.add_role :admin
      puts "======Admin user created======"
    end
  end
end
