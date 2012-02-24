class Bit < ActiveRecord::Base
  validates_presence_of :code, :title, :user
  validates :title, length: { minimum: 2, maximum: 160 }
  validates :description, length: { maximum: 3000 }
  validates :code, length: { minimum: 3, maximum: 2000 }
  validates :password, length: { minimum: 3, maximum: 300 }
  attr_accessible :title, :code, :description, :user
  belongs_to :user
  after_create :vote_once
  acts_as_voteable
  opinio_subjectum
  acts_as_taggable

  def vote_once
    self.user.vote_exclusively_for self
  end
end
