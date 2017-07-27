require 'securerandom'

class User < ActiveRecord::Base

  validates :user_name, :session_token, :password_digest, presence: true
  validates :user_name, :session_token, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  after_initialize :ensure_session_token

  has_many :cats,
    class_name: :Cat,
    primary_key: :id,
    foreign_key: :user_id

  has_many :rental_requests,
    class_name: :CatRentalRequest,
    primary_key: :id,
    foreign_key: :user_id

  has_many :session_tokens

  attr_reader :password

  def self.generate_session_token
    SecureRandom.urlsafe_base64(16)
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(user_name: username)
    if user && user.is_password?(password)
      user.reset_session_token!
      user
    else
      nil
    end
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    self.session_token = User.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_session_token
  end


end
