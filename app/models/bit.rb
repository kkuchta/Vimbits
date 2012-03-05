class Bit < ActiveRecord::Base
  validates_presence_of :code, :title, :user
  validates :title, length: { minimum: 2, maximum: 160 }
  validates :description, length: { maximum: 3000 }
  validates :code, length: { minimum: 3, maximum: 2000 }
  attr_accessible :title, :code, :description, :user
  belongs_to :user
  after_create :vote_once
  acts_as_voteable
  opinio_subjectum
  acts_as_taggable

  def vote_once
    self.user.vote_exclusively_for self
  end

  # Simplified HN algorithm: http://amix.dk/blog/post/19574
  def hotness

    # Vote score
    p = self.plusminus

    # Hours since creation of bit (rounded to nearest hour)
    t = ((Time.now - self.created_at) / 3600).round(0)

    # Gravity
    g = 1.8

    # Score formula: scores degrade towards 0 as a funciton of time.
    score = (p-1) / (t+2)**g

    return score
  end
end
