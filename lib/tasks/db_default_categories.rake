namespace :db do
  namespace :data do
    desc "Adding default categories"
    task :create_default_categories => :environment do
      Category.destroy_all
      Category.create(:id => 1, :name => "Customer Testimonials", :active => 1)
      Category.create(:id => 2, :name => "Products",              :active => 1)
      Category.create(:id => 3, :name => "Top Selling",           :active => 1)
      Category.create(:id => 4, :name => 'Home Carousel',         :active => 1)
      Category.create(:id => 5, :name => 'Team',                  :active => 1)
      Category.create(:id => 6, :name => 'Usp',                   :active => 1)
      Category.create(:id => 7, :name => 'Pricelist',             :active => 1)
      puts "======Default Categories created======"
    end
  end
end