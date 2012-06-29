namespace :db do
  namespace :data do
    desc "Adding default users"
    task :create_admin_user => :environment do
      user = User.create(:id => 1, :name => "James Wachira", :email => "admin@echochicks.com", :password => "1qaz2wsx", :password_confirmation => "1qaz2wsx", :confirmed_at => Time)
      user.add_role :admin
      puts "======Admin user created======"
    end
  end
end
