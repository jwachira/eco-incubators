namespace :db do
  namespace :data do
    desc "Adding default users"
    task :create_admin_user => :environment do
      User.destroy_all
      users = [
        ['James Wachira',  'jamomathenge@gmail.com', '1qaz2wsx'],
        ['Martin Kaberia', "martinkiraikabe@gmail.com", '1qaz2wsx'],
        ['Hoppa Otieno', "martinkiraikabe@gmail.com", '1qaz2wsx'],
      ]

      users.each do |user|
        user = User.find_or_create_by_email(:name                  => user[0],
                                            :email                 => user[1],
                                            :password              => user[2],
                                            :password_confirmation => user[2],
                                            :confirmed_at          => Time.now
                                            )
        user.save
        user.add_role :admin
      end
      puts "======Admin user created======"
    end
  end
end
