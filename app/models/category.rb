class Category < ActiveRecord::Base
  
  has_many :pages
  
  attr_accessible :name, :parent_id, :active
end
