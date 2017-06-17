class User < ApplicationRecord
  after_initialize :ensure_session_token
  # attr_reader :password
  validates :password, length: {minimum: 6, allow_nil: true}
  validates :username, :password_digest, presence: true, uniqueness: true

  has_many :posts
  has_many :comments

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token
    self.session_token ||= SecureRandom::urlsafe_base64(32)
  end

  def reset_session_token!
    self.session_token = SecureRandom::urlsafe_base64(32)
    self.save!
    self.session_token
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_username_and_password(username, password)
    user = self.where("username = ?", username)
    if user.nil?
      return false
    elsif user.is_password?(password)
      return user
    end
    return false
  end

end
