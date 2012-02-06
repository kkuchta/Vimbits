class Bit < ActiveRecord::Base
  validates_presence_of :code, :title
  attr_accessible :title, :code, :description
  belongs_to :user
  acts_as_voteable
end
