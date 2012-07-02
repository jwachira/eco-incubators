class Category < ActiveRecord::Base
  belongs_to :parent, :class_name => "Category", :foreign_key => "parent_id"
  has_many :pages

  attr_accessible :name, :parent_id, :active


  def status
    if self.active?
      "Published"
    else
      "Draft"
    end
  end

  def self.carousel
    find(:first, :conditions => ["categories.name =?", 'Home Carousel'])
  end
  
end
