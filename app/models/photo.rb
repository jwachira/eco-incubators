class Photo < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true
  attr_accessible :image
  mount_uploader :image, ImageUploader
end
