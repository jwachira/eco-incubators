class Page < ActiveRecord::Base

  belongs_to :category

  attr_accessible :title, :short_description, :long_description, :active, :is_product, :quantity, :price, :image, :remote_image_url, :category_id

  mount_uploader :image, ImageUploader

  def status
    if self.active?
      "Published"
    else
      "Draft"
    end
  end

  def self.carousel
    Page.scoped(:joins => :category, :conditions => ["categories.name =?", 'Home Carousel'], :limit => 3)
  end

  def self.top_selling
    Page.scoped(:joins => :category, :conditions => ["categories.name =?", 'Top Selling Incubators'], :limit => 3)
  end

  def self.about_us
    Page.find(:first, :conditions => ["pages.title =?", 'About Us'])
  end

  def self.contact_us
    Page.find(:first, :conditions => ["pages.title =?", 'Contact Us'])
  end

  def self.products
    Page.scoped(:joins => :category, :conditions => ["categories.name =?", 'Products'])
  end

  def self.customer_testimonials
    Page.scoped(:joins => :category, :conditions => ["categories.name =?", 'Customer Testimonials'], :limit => 3)
  end
  
  def to_param
    "#{title.downcase.gsub(/[^a-z0-9]+/i, '-')}-#{id}"
  end

end
