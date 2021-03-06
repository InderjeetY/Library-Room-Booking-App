class User < ApplicationRecord
  has_many :bookings

  has_secure_password

  EMAIL_REGEX = /\A[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\z/i

  validates :name, :presence => true
  validates :email_id, :presence => true, :format => EMAIL_REGEX, :uniqueness => true
  validates :password, :presence => true

  def get_user_bookings(room_id = '')
    User.select('*').joins(:bookings).where('bookings.room_id = ?',room_id)
  end

  def self.check_email_ids(email)
    @mailids = email.split(';')
    @mailids.each do |user_email|
      user_email_id = user_email.strip
      if User.find_by(email_id: user_email_id)
      else
        return TRUE
      end
    end
    FALSE
  end

end
