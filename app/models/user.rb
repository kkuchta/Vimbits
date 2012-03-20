class User < ActiveRecord::Base
  has_secure_password
  validates_presence_of :password, :on => :create
  validates :password, length: { minimum: 3, maximum: 254 }
  validates :username, length: { minimum: 3, maximum: 40 }
  validates :email, length: { minimum: 3, maximum: 254 }
  validates :email, format: { with: /.+\@.+\..+/, message: 'Invalid email address.' }

  validates :username, uniqueness: true
  validates :email, uniqueness: true

  attr_accessible :email, :password, :password_confirmation, :username
  has_many :bits
  acts_as_voter

  # Password reset functionality is taken pretty much directly from Railscast
  # #274 - http://asciicasts.com/episodes/274-remember-me-reset-password

  def generate_token(column)  
    begin  
      self[column] = SecureRandom.urlsafe_base64  
    end while User.exists?(column => self[column])  
  end  

  def send_password_reset  
    generate_token(:password_reset_token)  
    self.password_reset_sent_at = Time.zone.now  
    save!  
    UserMailer.password_reset(self).deliver  
  end  
  
end
