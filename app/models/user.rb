class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  attr_accessible :email, :password, :password_confirmation  
  has_many :bits
  acts_as_voter
end
