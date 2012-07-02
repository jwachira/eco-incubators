puts 'SETTING UP DEFAULT USERS LOGIN'
user = User.create! :name => 'Normal User', :email => 'chaitulittle@gmail.com', :password => '1qaz2wsx', :password_confirmation => '1qaz2wsx', :confirmed_at => Time.now 
puts 'New user created: ' << user.name
user = User.create! :name => 'Admin User', :email => 'chaitulittle1@gmail.com', :password => '1qaz2wsx', :password_confirmation => '1qaz2wsx', :confirmed_at => Time.now 
user.add_role :admin
puts 'New user created: ' << user.name

puts 'setting up default categories'
category = Category.create! :name => 'Testimonials', :active => 1
category = Category.create! :name => 'Products'    , :active => 1
category = Category.create! :name => 'Top Selling' , :active => 1


