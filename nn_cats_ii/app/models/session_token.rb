class SessionToken < ActiveRecord::Base
  validates :user_id, :session_token, :ip_address, presence: true
  validates :session_token, uniqueness: true

  belongs_to :user

end
