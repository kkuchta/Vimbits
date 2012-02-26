class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  validates :password, length: { minimum: 3, maximum: 300 }
  validates :email, format: { with: /.+\@.+\..+/, message: 'Invalid email address.' }
  attr_accessible :email, :password, :password_confirmation  
  has_many :bits
  acts_as_voter
end
