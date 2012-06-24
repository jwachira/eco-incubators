class User < ActiveRecord::Base
	rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :confirmed_at
  
  
  def is_admin?
    self.has_role? :admin
  end
  
end
