class Bit < ActiveRecord::Base
  validates_presence_of :code, :title
  belongs_to :user
end
