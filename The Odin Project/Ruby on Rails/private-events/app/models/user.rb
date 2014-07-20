class User < ActiveRecord::Base
  has_many :events, foreign_key: "creator_id"

  has_many :invites, foreign_key: "attendee_id"
  has_many :attended_events, through: :invites

  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }

  def upcoming_events
    self.attended_events.upcoming
  end

  def previous_events
    self.attended_events.past
  end

  def attending?(event)
    event.attendees.include?(self)
  end

  def attend!(event)
    self.invites.create!(attended_event_id: event.id)
  end

  def cancel!(event)
    self.invites.find_by(attended_event_id: event.id).destroy
  end	

  def User.new_remember_token
   	SecureRandom.urlsafe_base64
  end

  def User.digest(token)
   	Digest::SHA1.hexdigest(token.to_s)
  end

  private

   	def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end    
end
