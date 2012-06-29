namespace :db do
  namespace :data do
    desc "Adding default categories"
    task :create_default_categories => :environment do
      Category.create(:id => 1, :name => "Testimonials", :active => 1)
      Category.create(:id => 2, :name => "Products", :active => 1)
      Category.create(:id => 3, :name => "Top Selling", :active => 1)
      puts "======Default Categories created======"
    end
  end
end