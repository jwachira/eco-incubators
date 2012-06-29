class Page < ActiveRecord::Base
  
  belongs_to :category
  
  attr_accessible :title, :short_description, :long_description, :active, :is_product, :quantity, :price, :image, :remote_image_url
  
  mount_uploader :image, ImageUploader
end
