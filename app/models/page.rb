class Page < ActiveRecord::Base
  has_many   :photos, :as => :imageable
  belongs_to :category
  has_many   :children, :foreign_key => "parent_id" , :class_name=> "Page" , :dependent => :destroy
  belongs_to :parent,   :foreign_key => "parent_id" , :class_name=> "Page"
  
  attr_accessible :title, :short_description, :long_description, :active, :is_product, :quantity, :price, :image, :remote_image_url, :category_id, :parent_id, :photos_attributes

  mount_uploader :image, ImageUploader


  accepts_nested_attributes_for :photos, :allow_destroy => true
  
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
  
  def self.usp
    Page.scoped(:joins => :category, :conditions => ["categories.name =?", 'Usp'], :limit => 6)
  end
  
  def self.team
    Page.scoped(:joins => :category, :conditions => ["categories.name =?", 'Team'], :limit => 3)
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
